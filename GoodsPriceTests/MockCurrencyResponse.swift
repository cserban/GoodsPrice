//
//  MockCurrencyResponse.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation
@testable import GoodsPrice

class MockCurrencyResponse {
    var jsonData: Data
    var json: Any?

    init?(forResource: String = "CurrencyResponse", ofType: String = "json") {
        guard let path = Bundle.main.path(forResource: forResource, ofType: ofType) else {
            return nil
        }
        let pathURL = URL(fileURLWithPath: path)

        if let jsonData = try? Data(contentsOf: pathURL, options: .mappedIfSafe),
            let json = try? JSONSerialization.jsonObject(with: jsonData as Data,
                                                         options: JSONSerialization.ReadingOptions()) {
            self.jsonData = jsonData
            self.json = json
        } else {
            return nil
        }

    }
}
