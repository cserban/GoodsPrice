//
//  GoodsProviderTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 08/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import XCTest

@testable import GoodsPrice
class GoodsProviderTests: XCTestCase {

    var goodsProvider: GoodsProvider?
    let path = Bundle.main.path(forResource: "MockProducts", ofType: "plist")

    func testGoodsProviderWithMockProducts() {
        guard let path = path else {
            XCTFail("plist path invaild")
            return
        }
        guard let mockProducts = NSArray(contentsOfFile: path) as? MockProducts else {
            XCTFail("plist at path not vaild")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts)

        XCTAssertTrue(goodsProvider.products.count == mockProducts.count,
            "goodsProvider failed to init with correct number of mock data")
    }

    func testGoodsProviderWithoutMockData() {
        let goodsProvider = GoodsProvider()

        XCTAssertTrue(goodsProvider.products.count == 0,
                      "goodsProvider init without mockdata should have an empty product array")
    }

}
