//
//  Product.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

struct Product: Hashable {
    let displayName: String
    let priceValue: Float
    let currencyCode: String
    let messureUnit: String

    var hashValue: Int {
        return displayName.hashValue
    }

    init(displayName: String, priceValue: Float, currencyCode: String, messureUnit: String) {
        self.displayName = displayName
        self.priceValue = priceValue
        self.currencyCode = currencyCode
        self.messureUnit = messureUnit
    }

    init?(json: JSONDictionary) {
        guard let displayName = json["displayName"] as? String,
            let priceValue = (json["priceValue"] as? NSNumber)?.floatValue,
            let currencyCode = json["currencyCode"] as? String,
            let messureUnit = json["messureUnit"] as? String else {
                return nil
        }
        self.displayName = displayName
        self.priceValue = priceValue
        self.currencyCode = currencyCode
        self.messureUnit = messureUnit
    }

}

func == (lhs: Product, rhs: Product) -> Bool {
    return lhs.displayName == rhs.displayName
}
