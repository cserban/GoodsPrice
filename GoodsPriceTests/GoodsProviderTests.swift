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

    var goodsProvider: GoodsProvider?
    let path = Bundle.main.path(forResource: "MockProducts", ofType: "plist")
    var mockProducts: MockProducts = []

    override func setUp() {
        super.setUp()
        guard let path = path else {
            XCTFail("plist path invaild")
            return
        }
        guard let mockProducts = NSArray(contentsOfFile: path) as? MockProducts else {
            XCTFail("plist at path not vaild")
            return
        }
        self.mockProducts = mockProducts
    }

    func testGoodsProviderWithMockProducts() {
        let goodsProvider = GoodsProvider(mockProducts: mockProducts)

        XCTAssertTrue(goodsProvider.products.count == mockProducts.count,
                      "goodsProvider failed to init with correct number of mock data")
    }

    func testGoodsProviderWithoutMockData() {
        let goodsProvider = GoodsProvider()

        XCTAssertTrue(goodsProvider.products.isEmpty,
                      "goodsProvider init without mockdata should have an empty product array")
    }

}
