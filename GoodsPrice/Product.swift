//
//  Product.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

struct Product {
    let displayName: String
    let priceValue: Float
    let currencyCode: String
    let messureUnit: String

    init?(dictionary: [String: Any]) {
        guard let displayName = dictionary["displayName"] as? String,
            let priceValue = (dictionary["priceValue"] as? NSNumber)?.floatValue,
            let currencyCode = dictionary["currencyCode"] as? String,
            let messureUnit = dictionary["messureUnit"] as? String else {
                return nil
        }
        self.displayName = displayName
        self.priceValue = priceValue
        self.currencyCode = currencyCode
        self.messureUnit = messureUnit
    }
}
