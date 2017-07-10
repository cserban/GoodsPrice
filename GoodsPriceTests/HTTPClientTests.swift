//
//  HTTPClientTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class HTTPClientTests: XCTestCase {
    var productResource: Resource<CurrencyResponse>?
    var subject: HTTPClient?
    let session = MockURLSession()

    override func setUp() {
        super.setUp()
        guard let infoDictionary = Bundle.main.infoDictionary,
            let url = infoDictionary["CurrencyURL"] as? String,
            let accessKey = infoDictionary["CurrencyAccessKey"] as? String,
            let correncyResourceUrl = URL(string: "\(url)live?access_key=\(accessKey)") else {
                XCTFail("HTTPClient url is invaild")
                return
        }
        productResource = Resource<CurrencyResponse>(url: correncyResourceUrl,
                                                     parseJSON: { anyObject in
                                                            (anyObject as? JSONDictionary)
                                                                .flatMap(CurrencyResponse.init)
        })
    }

    func testMockSessionHTTPClientRequestsValues() {
        subject = HTTPClient(session: session)
        guard let productResource = productResource else {
            XCTFail("Resource is invaild")
            return
        }

        subject?.load(resource: productResource) { _ in }
        if let request = session.request {
            XCTAssertTrue(request == productResource, "HTTPClient request is not set corretly")
        } else {
            XCTFail("HTTPClient session request is null")
        }
    }

    func testMockSessionHTTPClientRequestsStarted() {
        subject = HTTPClient(session: session)
        guard let productResource = productResource else {
            XCTFail("Resource is invaild")
            return
        }
        let dataTask = MockURLSessionDataTask()
        session.dataTask = dataTask
        subject?.load(resource: productResource) { _ in }

        XCTAssertTrue(session.dataTask.resumeWasCalled, "HTTPClient request resume is not called")

    }

    func testMockSessionHTTPClientRequestsReturnData() {
        subject = HTTPClient(session: session)
        guard let productResource = productResource else {
            XCTFail("Resource is invaild")
            return
        }
        guard let mockCurrencyResponse = MockCurrencyResponse() else {
            XCTFail("CurrencyResponse mock data is invaild")
            return
        }

        var currencyResponse: CurrencyResponse?
        let expectedData = mockCurrencyResponse.jsonData
        session.data = expectedData
        subject?.load(resource: productResource) { (resource, error) -> Void in
            if let error = error {
                 XCTFail("HTTPClient request with mock data faild with error: \(error)")
            } else if let resource = resource {
                currencyResponse = resource
                XCTAssertTrue(!resource.quotes.isEmpty,
                              "HTTPClient with mock data faild without an error but with empty quotes")
            } else {
                XCTFail("HTTPClient request with mock data faild")
            }
        }
        XCTAssertNotNil(currencyResponse, "HTTPClient with mock data faild")
    }

    func testSessionHTTPClientRequestReturnCurrencyResponse() {
        guard let productResource = productResource else {
            XCTFail("Resource is invaild")
            return
        }
        subject = HTTPClient()
        var currencyResponse: CurrencyResponse?
        let exp = expectation(description: "Wait for currencyResponse to load.")

        subject?.load(resource: productResource) { (currencyResponseData, _) -> Void in
            currencyResponse = currencyResponseData
            exp.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("HTTPClientRequest wait For Expectation With Timeout errored: \(error)")
            }
        }
        XCTAssertNotNil(currencyResponse)
    }

}
