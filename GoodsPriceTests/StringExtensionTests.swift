//
//  StringExtensionTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 11/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class StringExtensionTests: XCTestCase {
    let quate = "EURUSD"

    func testEurIndexFound() {
        let substring = "EUR"
        let index = quate.startIndexOfSubstriong(substring: substring)
        XCTAssertNotNil(index, "start index of \(substring) in \(quate) should exist")
        XCTAssertTrue(index == 0, "start index of \(substring) in \(quate) should be 0")
    }

    func testUSDIndexFound() {
        let substring = "USD"
        let index = quate.startIndexOfSubstriong(substring: substring)
        XCTAssertNotNil(index, "start index of \(substring) in \(quate) should exist")
        XCTAssertTrue(index == 3, "start index of \(substring) in \(quate) should be 3")
    }

    func testIndexNotFound() {
        let substring = "XX"
        let index = quate.startIndexOfSubstriong(substring: substring)
        XCTAssertNil(index, "start index of \(substring) in \(quate) should not exist")
    }
}
