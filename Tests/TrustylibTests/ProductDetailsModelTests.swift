//
//  Copyright (C) 2023 Trusted Shops GmbH
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Prem Pratap Singh on 21/04/23.
//


import XCTest
@testable import Trustylib

typealias ProductDetailsResponseHandler = ([ProductDetailsModel]?, Error?) -> Void

/**
 ProductDetailsModelTests tests json parsing workflow and validity of the properties
 */
final class ProductDetailsModelTests: XCTestCase {
    private var productDetailsModel: ProductDetailsModel?

    override func tearDownWithError() throws {
        self.productDetailsModel = nil
    }

    func testProductDetailsServiceResponseIsDecodedAsValidDataObject() throws {
        self.getModalObjectForProductDetails(from: .productDetailsServiceResponseWithImages)
        XCTAssertNotNil(self.productDetailsModel,
                        "Product details service response json fails to decode as ProductDetailsModel")
    }

    func testProductDetailsObjectHasValidValues() {
        self.getModalObjectForProductDetails(from: .productDetailsServiceResponseWithImages)
        guard let productDetails = self.productDetailsModel else {
            XCTFail("Product details service response json fails to decode as ProductDetailsModel")
            return
        }

        XCTAssertTrue(productDetails.accountId.isEmpty == false,
                       "Product details data object should have valid account id")
        XCTAssertTrue(productDetails.name.isEmpty == false,
                       "Product details data object should have valid product name")
        XCTAssertNotNil(productDetails.url,
                       "Product details data object should have valid product details url")
        XCTAssertNotNil(productDetails.gtin,
                       "Product details data object should have valid gtin value")
        XCTAssertNotNil(productDetails.sku,
                       "Product details data object should have valid sku value")
        XCTAssertNotNil(productDetails.mpn,
                       "Product details data object should have valid mpn value")
        XCTAssertNotNil(productDetails.image,
                       "Product details data object should image urls")
    }
    
    func testProductDetailsObjectDoesntHaveImagesWhenMissingInJsonResponse() {
        self.getModalObjectForProductDetails(from: .productDetailsServiceResponseWithoutImages)
        guard let productDetails = self.productDetailsModel else {
            XCTFail("Product details service response json fails to decode as ProductDetailsModel")
            return
        }

        XCTAssertNil(productDetails.image,
                     "Product details data object should't have image when missing in service response JSON")
    }

    // MARK: Helper methods

    /**
     Calls `FileDataLoader` utility to load mock json data from local file and get `ProductDetailsModel`
     object after encoding the json data
     */
    private func getModalObjectForProductDetails(from: LocalDataFile) {
        let responseHandler: ProductDetailsResponseHandler = { response, error in
            guard error == nil,
                  let dataResponse = response,
                  let productDetailsModel = dataResponse.first else {
                return
            }
            self.productDetailsModel = productDetailsModel
        }

        let fileDataLoader = FileDataLoader()
        fileDataLoader.getData(for: from,
                                extenson: .json,
                                responseHandler: responseHandler)
    }

}
