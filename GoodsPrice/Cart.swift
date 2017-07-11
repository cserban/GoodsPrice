//
//  Cart.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 11/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

class Cart {
    var elements = [AnyHashable: Int]()
    var totalPriceInUSD: Float = 0.0

    init(products: [Product]) {
        for product in products {
            elements[product] = 0
        }
    }

    func incert(product: Product) {
        elements[product] = (elements[product] ?? 0) + 1
        totalPriceInUSD += product.priceValue
    }

    func remove(product: Product) {
        guard let currentNumberOfProducts = elements[product],
           currentNumberOfProducts - 1 >= 0 else { return }
        elements[product] = currentNumberOfProducts - 1
        totalPriceInUSD -= product.priceValue
    }
}
