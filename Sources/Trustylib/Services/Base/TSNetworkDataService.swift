//
//  TSNetworkDataService.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/**
 TSNetworkDataService calls a given Trustedshops backend API for loading required data.
 It supports generic concept so that it could be used to load data from any API and parsing the
 loaded data to any data type confirming to the Codable protocol
 */

protocol TSNetworkDataService: AnyObject {

    // MARK: Public properties

    /// Returns instance of the TSBackendServiceURL. It is used to form backend service endpoint URLs.
    var backendServiceURL: TSBackendServiceURL { get }

    // MARK: Public methods

    /// Returns header field's key-value pairs for calling backend service APIs
    var headerFields: [String: String]? { get }

    /// Makes call to the trusted shop data service APIs with the required parameters
    /// and handles result and error responses as returned by the API.
    ///
    /// It then delegates back the response/error for further processing via the responseHandler
    func getData<T: Codable>(
        request: TSNetworkServiceRequest,
        responseConfiguration: TSNetworkServiceResponseConfiguration?,
        responseHandler: @escaping TSNetworkServiceResponseHandler<T>
    ) -> URLSessionDataTask?
}

/**
 Defining default implementation of TSNetworkDataService API so that It could be reused in
 service classes adopting to TSNetworkDataService protocol
 */
extension TSNetworkDataService {

    var backendServiceURL: TSBackendServiceURL {
        return TSBackendServiceURL.shared
    }

    var headerFields: [String: String]? {
        let headerFields: [String: String] = [
            TSNetworkServiceHeaderField.contentType: TSNetworkServiceHeaderFieldValue.contentTypeJson,
            TSNetworkServiceHeaderField.accept: TSNetworkServiceHeaderFieldValue.acceptAll,
        ]
        return headerFields
    }

    func getData<T: Codable>(
        request: TSNetworkServiceRequest,
        responseConfiguration: TSNetworkServiceResponseConfiguration?,
        responseHandler: @escaping TSNetworkServiceResponseHandler<T>) -> URLSessionDataTask? {

        // Initializing request object for setting up URL session data task
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method

        // Adding request headers
        if let headerValues = request.headerValues {
            urlRequest.allHTTPHeaderFields = headerValues
        } else {
            urlRequest.allHTTPHeaderFields = [
                TSNetworkServiceHeaderField.contentType: request.contentType
            ]
        }

        // Adding request parameters, if any
        if let parameters = request.parameters,
           var urlComponents = URLComponents(string: request.url.absoluteString) {
            var queryItems = [URLQueryItem]()
            for (key,value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: value as? String ?? ""))
            }
            urlComponents.queryItems = queryItems
            if let url = urlComponents.url {
                urlRequest.url = url
            }
        }

        // Adding request body, if any
        if let httpBody = request.body {
            urlRequest.httpBody = httpBody
        }

        // Setting up data task for API call
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                responseHandler(nil, TSNetworkServiceError(type: .serverError, code: 500))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse,
                  let responseData = data else {
                responseHandler(nil, TSNetworkServiceError(type: .serverError, code: 500))
                return
            }

            if let responseConfiguration = responseConfiguration {
                // If server returned expected response code but the response doesn't have JSON data to process,
                // call the `responseHandler` with nil response and nil error
                if urlResponse.statusCode == responseConfiguration.expectedResponseCode.code
                    && !responseConfiguration.hasResponseData {
                    responseHandler(nil, nil)
                    return
                }

                // If server returned unexpected response code, call responseHandler with nil response data and
                // unexpectedResponseError error type and response code
                if urlResponse.statusCode == responseConfiguration.unexpectedResponseCode.code {
                    responseHandler(
                        nil,
                        TSNetworkServiceError(
                            type: .unexpectedResponseError,
                            code: urlResponse.statusCode
                        )
                    )
                    return
                }

                // If server returned error code, call responseHandler with nil response data and
                // server error type and response code
                if urlResponse.statusCode == responseConfiguration.errorResponseCode.code {
                    responseHandler(
                        nil,
                        TSNetworkServiceError(
                            type: .serverError,
                            code: urlResponse.statusCode)
                    )
                    return
                }
            } else if urlResponse.statusCode != 200 {
                // If server returned response code other then 200 (success response code),
                // call responseHandler with nil response data and server error type and response code
                responseHandler(
                    nil,
                    TSNetworkServiceError(
                        type: .serverError,
                        code: urlResponse.statusCode)
                )
                return
            }

            do {
                // Attempting to parse response data
                let decoder = JSONDecoder()
                let jsonResponseData = try JSONSerialization.jsonObject(with: responseData, options: [])
                var resultData = [T]()

                // If the server response is a list of objects
                if let listData = jsonResponseData as? [[String: Any]] {
                    for item in listData {
                        let itemData = try JSONSerialization.data(withJSONObject: item, options: [])
                        let decodedItem = try decoder.decode(T.self, from: itemData)
                        resultData.append(decodedItem)
                    }
                    responseHandler(resultData, nil)
                }
                // If the server response is a single object
                else {
                    let decodedItem = try decoder.decode(T.self, from: responseData)
                    resultData.append(decodedItem)
                    responseHandler(resultData, nil)
                }
            } catch {
                // If response parsing fails, calling response handler with nil data
                // and jsonParsingError type
                print(error.localizedDescription)
                responseHandler(nil, TSNetworkServiceError(type: .jsonParsingError, code: 500))
            }
        }

        // Calling API
        dataTask.resume()
        return dataTask
    }
}
