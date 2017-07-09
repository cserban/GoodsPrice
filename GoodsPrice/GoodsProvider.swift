//
//  GoodsProvider.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 08/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

typealias MockProducts = [[String: Any]]

struct GoodsProvider {
    var products: [Product] = []

    init(mockProducts: MockProducts? = nil) {
        if let mockProducts = mockProducts {
            self.products = mockProducts.map ({
                Product(dictionary: $0)
                }).flatMap ({
                    $0
            })
        }
    }
}
