//
//  FloatCurrencyExtensionTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class FloatCurrencyExtensionTests: XCTestCase {

    var price: Float = 0.0

    override func setUp() {
        super.setUp()
        price = 1.55
    }

    func testFloatCurrencyExtensionWithUSDValidCurrencyCodeWithoutSeparator() {
        let currencyCodeUSD = "USD"
        let priceStringWithCurrency = price.toCurrencyStringWith(currencyCode: currencyCodeUSD)
        XCTAssertNotNil(priceStringWithCurrency,
                        "toCurrencyStringWith valid currencyCode failed to return a string")
        XCTAssertTrue(priceStringWithCurrency == "$\(price)",
                      "toCurrencyStringWith valid currencyCode failed to return $\(price)")
    }

    func testFloatCurrencyExtensionWithUSDValidCurrencyCodeWithSeparator() {
        let currencyCodeUSD = "USD"
        let price: Float = 1021.55
        let priceStringWithCurrency = price.toCurrencyStringWith(currencyCode: currencyCodeUSD)
        XCTAssertNotNil(priceStringWithCurrency,
                        "toCurrencyStringWith valid currencyCode failed to return a string")
        XCTAssertTrue(priceStringWithCurrency == "$1,021.55",
                      "toCurrencyStringWith valid currencyCode failed to return $1,021.55")
    }

    func testFloatCurrencyExtensionWithEURValidCurrencyCodeWithoutSeparator() {
        let currencyCodeUSD = "GBP"
        let priceStringWithCurrency = price.toCurrencyStringWith(currencyCode: currencyCodeUSD)
        XCTAssertNotNil(priceStringWithCurrency,
                        "toCurrencyStringWith valid currencyCode failed to return a string")
        XCTAssertTrue(priceStringWithCurrency == "£\(price)",
                      "toCurrencyStringWith valid currencyCode failed to return £\(price)")
    }

    func testFloatCurrencyExtensionWithInValidCurrencyCode() {
        let currencyCodeUSD = "xxjkhx"
        let priceStringWithCurrency = price.toCurrencyStringWith(currencyCode: currencyCodeUSD)
        XCTAssertNil(priceStringWithCurrency,
                     "toCurrencyStringWith invalid currencyCode failed to return a null string")
    }

    func testFloatCurrencyExtensionWithEmptyCurrencyCode() {
        let currencyCodeUSD = ""
        let priceStringWithCurrency = price.toCurrencyStringWith(currencyCode: currencyCodeUSD)
        XCTAssertNil(priceStringWithCurrency,
                     "toCurrencyStringWith Empty currencyCode failed to return a null string")
    }
}
