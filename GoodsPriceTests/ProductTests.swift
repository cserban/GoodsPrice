//
//  ProductTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class ProductTests: XCTestCase {
    let validDictionary: JSONDictionary = [
        "displayName": "Peas",
        "priceValue": NSNumber(value:1.24),
        "currencyCode": "USD",
        "messureUnit": "bag"
    ]

    func testInitProductWithValidDictionary() {
        let product = Product(json: validDictionary)
        XCTAssertNotNil(product,
                        "Product init with valid dictionary failed to return a product instance")

        XCTAssertTrue(product?.displayName == (validDictionary["displayName"] as? String),
                      "Product init with valid dictionary faild to set displayName")
        XCTAssertTrue(product?.priceValue == (validDictionary["priceValue"] as? NSNumber)?.floatValue,
                      "Product init with valid dictionary faild to set priceValue")
        XCTAssertTrue(product?.currencyCode == (validDictionary["currencyCode"] as? String),
                      "Product init with valid dictionary faild to set currencyCode")
        XCTAssertTrue(product?.messureUnit == (validDictionary["messureUnit"] as? String),
                      "Product init with valid dictionary faild to set messureUnit")
    }

    func testInitProductWithInvalidDictionary() {
        let product = Product(json: ["currencyCode": "USD",
                                           "messureUnit": "bag"])
        XCTAssertNil(product, "Product init with invalid dictionary should fail")
    }

    func testInitProductWithEmptyDictionary() {
        let product = Product(json: [:])
        XCTAssertNil(product,
                     "Product init with empty dictionary should fail")
    }
}
