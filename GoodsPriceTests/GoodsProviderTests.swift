//
//  GoodsProviderTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 08/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class GoodsProviderTests: XCTestCase {
    var mockProducts: MockProducts?

    override func setUp() {
        super.setUp()
        mockProducts = MockProducts()
    }

    func testGoodsProviderWithMockProducts() {
        let goodsProvider = GoodsProvider(mockProducts: mockProducts?.productsArray)

        XCTAssertTrue(goodsProvider.products.count == mockProducts?.productsArray.count,
                      "goodsProvider failed to init with correct number of mock data")
    }

    func testGoodsProviderWithoutMockData() {
        let goodsProvider = GoodsProvider()

        XCTAssertTrue(goodsProvider.products.isEmpty,
                      "goodsProvider init without mockdata should have an empty product array")
    }

}
