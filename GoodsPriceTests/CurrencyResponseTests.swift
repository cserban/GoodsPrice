//
//  CurrencyResponseTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class CurrencyResponseTests: XCTestCase {
    let validDictionary: JSONDictionary = [
        "success": true,
        "terms": "https://currencylayer.com/terms",
        "privacy": "https://currencylayer.com/privacy",
        "timestamp": 1_499_636_046 ,
        "source": "USD",
        "quotes": [
            "USDAED": 3.6727 ,
            "USDAFN": 68.230_003 ,
            "USDALL": 115.750_056
        ]
    ]

    func testInitCurrencyResponseWithValidDictionary() {
        let currencyResponse = CurrencyResponse(json: validDictionary)
        XCTAssertNotNil(currencyResponse,
                        "CurrencyResponse init with valid dictionary failed to return a currencyResponse instance")

        XCTAssertTrue(currencyResponse?.success == (validDictionary["success"] as? Bool),
                      "CurrencyResponse init with valid dictionary faild to set success")
        XCTAssertTrue(currencyResponse?.terms == (validDictionary["terms"] as? String),
                      "CurrencyResponse init with valid dictionary faild to set terms")
        XCTAssertTrue(currencyResponse?.privacy == (validDictionary["privacy"] as? String),
                      "CurrencyResponse init with valid dictionary faild to set privacy")
        XCTAssertTrue(currencyResponse?.timestamp == (validDictionary["timestamp"] as? Int),
                      "CurrencyResponse init with valid dictionary faild to set timestamp")
        XCTAssertTrue(currencyResponse?.source == (validDictionary["source"] as? String),
                      "CurrencyResponse init with valid dictionary faild to set source")
        XCTAssertTrue(currencyResponse?.quotes.count == (validDictionary["quotes"] as? JSONDictionary)?.count,
                      "CurrencyResponse init with valid dictionary faild to set quotes number")
        if let keys = (validDictionary["quotes"] as? JSONDictionary)?.keys {
            for key in keys {
                XCTAssertTrue(currencyResponse?.quotes[key] ==
                    (validDictionary["quotes"] as? JSONDictionary)?[key] as? Double,
                              "CurrencyResponse init with valid dictionary faild to set \(key)")
            }
        }
    }

    func testInitCurrencyResponseWithDefaultInit() {
        guard let success = validDictionary["success"] as? Bool,
            let terms = validDictionary["terms"] as? String,
            let privacy = validDictionary["privacy"] as? String,
            let timestamp = validDictionary["timestamp"] as? Int,
            let source = validDictionary["source"] as? String,
            let quotes = validDictionary["quotes"] as? [String : Double] else {
                XCTFail("CurrencyResponse mock data is invaild")
                return
        }

        let currencyResponse = CurrencyResponse(success: success,
                                                terms: terms,
                                                privacy: privacy,
                                                timestamp: timestamp,
                                                source: source,
                                                quotes: quotes)

        XCTAssertTrue(currencyResponse.success == (validDictionary["success"] as? Bool),
                      "CurrencyResponse init with valid dictionary faild to set success")
        XCTAssertTrue(currencyResponse.terms == (validDictionary["terms"] as? String),
                      "CurrencyResponse init with valid dictionary faild to set terms")
        XCTAssertTrue(currencyResponse.privacy == (validDictionary["privacy"] as? String),
                      "CurrencyResponse init with valid dictionary faild to set privacy")
        XCTAssertTrue(currencyResponse.timestamp == (validDictionary["timestamp"] as? Int),
                      "CurrencyResponse init with valid dictionary faild to set timestamp")
        XCTAssertTrue(currencyResponse.source == (validDictionary["source"] as? String),
                      "CurrencyResponse init with valid dictionary faild to set source")
        XCTAssertTrue(currencyResponse.quotes.count == (validDictionary["quotes"] as? JSONDictionary)?.count,
                      "CurrencyResponse init with valid dictionary faild to set quotes number")
        if let keys = (validDictionary["quotes"] as? JSONDictionary)?.keys {
            for key in keys {
                XCTAssertTrue(currencyResponse.quotes[key] ==
                    (validDictionary["quotes"] as? JSONDictionary)?[key] as? Double,
                              "CurrencyResponse init with valid dictionary faild to set \(key)")
            }
        }
    }

    func testInitCurrencyResponseWithInvalidDictionary() {
        let currencyResponse = CurrencyResponse(json: ["success": true,
                                                       "terms": "https://currencylayer.com/terms"])
        XCTAssertNil(currencyResponse, "CurrencyResponse init with invalid dictionary should fail")
    }

    func testInitCurrencyResponsetWithEmptyDictionary() {
        let currencyResponse = CurrencyResponse(json: [:])
        XCTAssertNil(currencyResponse,
                     "CurrencyResponse init with empty dictionary should fail")
    }
}
