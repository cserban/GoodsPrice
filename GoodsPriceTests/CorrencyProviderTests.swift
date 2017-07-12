//
//  CorrencyProviderTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 11/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class CurrencyProviderTests: XCTestCase {
    var currencyProvider: CurrencyProvider?
    var session = MockURLSession()

    override func setUp() {
        super.setUp()
        self.session = MockURLSession()
        let subject = HTTPClient(session: session)
        currencyProvider = CurrencyProvider(httpClient: subject)
    }

    func testCurrencyProviderMockHTTPClientInit() {
        XCTAssertNotNil(currencyProvider?.httpClient, "CurrencyProvider was not init correctly")
    }

    func testCurrencyProviderMockHTTPClientWithInvalidBundle() {
        let bundle = Bundle()
        currencyProvider = CurrencyProvider(bundle: bundle)
        XCTAssertNil(currencyProvider?.httpClient, "CurrencyProvider was not init correctly")
    }

    func testCurrencyProviderMockHTTPClientLoadQuates() {
        guard let mockCurrencyResponse = MockCurrencyResponse() else {
            XCTFail("CurrencyResponse mock data is invaild")
            return
        }
        guard let currencyProvider = currencyProvider else {
            XCTFail("currencyProvider is invaild")
            return
        }
        let expectedData = mockCurrencyResponse.jsonData
        session.data = expectedData
        currencyProvider.loadQuates(completion: { success in
            if !success {
                XCTFail("CurrencyProvider faild to load data with success")
            }
        })

        XCTAssertFalse(currencyProvider.quotes.isEmpty, "CurrencyProvider with mock data faild to load quotes")
    }
}
