//
//  GoodsProvider.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 08/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

typealias ProductsArray = [[String: Any]]

struct GoodsProvider {
    var products: [Product] = []

    init(mockProducts: ProductsArray? = nil) {
        if let mockProducts = mockProducts {
            self.products = mockProducts.map ({
                Product(json: $0)
                }).flatMap ({
                    $0
            })
        }
    }
}
