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
    let path = Bundle.main.path(forResource: "CurrencyResponse", ofType: "json")
    var json: Any?

    override func setUp() {
        super.setUp()
        guard let path = path else {
            XCTFail("CurrencyResponse mock json path invaild")
            return
        }
        let pathURL = URL(fileURLWithPath: path)

        if let jsonData = try? Data(contentsOf: pathURL, options: .mappedIfSafe),
             let json = try? JSONSerialization.jsonObject(with: jsonData as Data,
                                                          options: JSONSerialization.ReadingOptions()) {
            self.json = json
        } else {
            XCTFail("CurrencyResponse mock json is invaild")
        }
    }

    func testResourceInitWithValidCurrencyResponseJson(){
        //TO DO
    }

}
