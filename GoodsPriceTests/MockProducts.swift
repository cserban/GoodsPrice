//
//  MockProducts.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 11/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation
@testable import GoodsPrice

class MockProducts {

    var productsArray: ProductsArray = []

    init?(forResource: String = "MockProducts", ofType: String = "plist") {
        guard let path = Bundle.main.path(forResource: "MockProducts", ofType: "plist") else {
            return nil
        }
        guard let mockProducts = NSArray(contentsOfFile: path) as? ProductsArray else {
            return nil
        }
        self.productsArray = mockProducts
    }
}
