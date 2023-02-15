//
//  FileDataLoader.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 14/02/23.
//

import Foundation

typealias ResponseHandler<T: Codable> = ([T]?, Error?) -> Void

/**
 FileDataLoader helps loading data from local files and encodes them into the
 desired model data objects.

 It is primarily used for unit testing purpose to load test/mock data for view models
 */

class FileDataLoader {
    func getData<T: Codable>(for file: LocalDataFile,
                             extenson: LocalDataFileExtension,
                             responseHandler: @escaping ResponseHandler<T>) {

        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: file.name, withExtension: extenson.name) else {
            responseHandler(nil, FileDataServiceError.fileNotFound)
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonResponseData = try JSONSerialization.jsonObject(with: data, options: [])
            var resultData = [T]()

            /// If the response had a list of objects
            if let listData = jsonResponseData as? [[String: Any]] {
                for item in listData {
                    let itemData = try JSONSerialization.data(withJSONObject: item, options: [])
                    let decodedItem = try decoder.decode(T.self, from: itemData)
                    resultData.append(decodedItem)
                }
                responseHandler(resultData, nil)
            }
            /// If the response has a single object
            else {
                let decodedItem = try decoder.decode(T.self, from: data)
                resultData.append(decodedItem)
                responseHandler(resultData, nil)
            }
        } catch {
            responseHandler(nil, FileDataServiceError.dataParseError)
        }
    }
}

/**
Enumaration for local data file names
*/
enum LocalDataFile: String {

    case authenticationServiceResponse = "authentication_service_response"
    case trustmarkDetailsServiceResponse = "trustmark_details_service_response"
    case aggregateRatingsServiceResponse = "aggregate_rating_service_response"

    // MARK: Public properties

    var name: String {
        return self.rawValue
    }
}

/**
Enumaration for local data file extensions
*/
enum LocalDataFileExtension: String {

    case json = "json"
    case xml = "xml"

    // MARK: Public properties

    var name: String {
        return self.rawValue
    }
}


/**
Wrapper enumeration for errors specific to the file data service
*/
enum FileDataServiceError: String, Error {
    case fileNotFound = "Couldn't find the given file"
    case dataParseError = "Unable to parse file data"

    var description: String {
        return self.rawValue
    }
}
