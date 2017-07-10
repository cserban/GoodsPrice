//
//  CurrencyResponseTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class ResourceTests: XCTestCase {
    var mockCurrencyResponse: MockCurrencyResponse?

    override func setUp() {
        super.setUp()
        guard let mockCurrencyResponse = MockCurrencyResponse() else {
            XCTFail("CurrencyResponse mock data is invaild")
            return
        }
        self.mockCurrencyResponse = mockCurrencyResponse
    }

    func testResourceInitWithValidCurrencyResponseJson() {
        //TO DO
    }

}
