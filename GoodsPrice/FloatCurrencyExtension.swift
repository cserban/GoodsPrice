//
//  FloatCurrencyDisplayExtension.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

extension Float {
    func toCurrencyStringWith(currencyCode: String) -> String? {
        guard Locale.isoCurrencyCodes.contains(currencyCode) else {
            return nil
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: self))
    }
}
