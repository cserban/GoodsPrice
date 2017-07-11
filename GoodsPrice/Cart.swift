//
//  Cart.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 11/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

enum ConversionDirection {
    case multiplication
    case division
}

class Cart {
    var elements = [AnyHashable: Int]()
    var totalPriceUnits: Float = 0.0
    var currencyCode: String?
    let doubleQuateCharactersCount = 6
    var singleQuateCharactersCount: Int {
        return doubleQuateCharactersCount / 2
    }

    init(products: [Product]) {
        for product in products {
            elements[product] = 0
            currencyCode = product.currencyCode
        }
    }

    func incert(product: Product) {
        if let currentNumberOfProducts = elements[product] {
            elements[product] = currentNumberOfProducts + 1
        } else {
            elements[product] = 1
        }
        totalPriceUnits += product.priceValue
    }

    func remove(product: Product) {
        guard let currentNumberOfProducts = elements[product],
           currentNumberOfProducts - 1 >= 0 else { return }
        elements[product] = currentNumberOfProducts - 1
        totalPriceUnits -= product.priceValue
    }

    func priceFor(quate: String, quateValue: Double) -> Float? {
        guard let conversionDirection = getConversionDirectionFor(quate: quate) else {
            return nil
        }
        switch conversionDirection {
        case .multiplication:
            return totalPriceUnits * Float(quateValue)
        case .division:
            return totalPriceUnits / Float(quateValue)
        }
    }

    private func getConversionDirectionFor(quate: String) -> ConversionDirection? {
        guard quate.characters.count == doubleQuateCharactersCount,
              let currencyCode = currencyCode,
              let index = quate.startIndexOfSubstriong(substring: currencyCode) else {
                return nil
        }

        switch index {
        case 0:
            return .multiplication
        case singleQuateCharactersCount:
            return .division
        default:
            return nil
        }
    }
}
