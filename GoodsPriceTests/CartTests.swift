//
//  CartTests.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 11/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

@testable import GoodsPrice
import XCTest

class CartTests: XCTestCase {
    var mockProducts: MockProducts?

    override func setUp() {
        super.setUp()
        mockProducts = MockProducts()
    }

    func testCartInitWithValidProductList() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        XCTAssertTrue(cart.elements.keys.count == mockProducts.productsArray.count,
                      "cart initial elements are not from GoodsProvider")
        XCTAssertTrue(cart.totalPriceInUSD == 0, "cart initial price is not 0")
    }

    func testCartIncertProduct() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let product = goodsProvider.products[0]
        cart.incert(product: product)

        XCTAssertTrue(cart.elements[product] == 1,
                      "cart after incert of a product should have value 1 for that product hash")
        XCTAssertTrue(cart.totalPriceInUSD == product.priceValue,
                      "cart after incert of a product should have the totalPriceInUSD equal with the product price")
    }

    func testCartIncertProductAndRemoveIt() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let product = goodsProvider.products[0]
        cart.incert(product: product)
        cart.remove(product: product)

        XCTAssertTrue(cart.elements[product] == 0,
                      "cart after incert of a product should have value 1 for that product hash")
        XCTAssertTrue(cart.totalPriceInUSD == 0,
                      "cart after incert of a product should have the totalPriceInUSD equal with the product price")
    }

    func testCartIncertTwoProducts() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let productOne = goodsProvider.products[0]
        let productTwo = goodsProvider.products[1]
        cart.incert(product: productOne)
        cart.incert(product: productTwo)

        XCTAssertTrue(cart.elements[productOne] == 1 &&
                      cart.elements[productTwo] == 1,
                      "cart after incert of two diffrent products should have value 1 for each product hash")

        XCTAssertTrue(cart.totalPriceInUSD == (productOne.priceValue + productTwo.priceValue),
                      "cart after incert of two diffrent products should have the totalPriceInUSD currect")
    }

    func testCartIncertTwoProductsAndRemoveOne() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let productOne = goodsProvider.products[0]
        let productTwo = goodsProvider.products[1]
        cart.incert(product: productOne)
        cart.incert(product: productTwo)
        cart.remove(product: productOne)

        XCTAssertTrue(cart.elements[productOne] == 0 &&
            cart.elements[productTwo] == 1,
                      "cart after incert of two diffrent and remove one product should have correct values")

        XCTAssertTrue(cart.totalPriceInUSD == productTwo.priceValue,
                      "cart after incert of two products and remove one should have the totalPriceInUSD currect")
    }

    func testCartIncertSameProductTwice() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let product = goodsProvider.products[0]
        cart.incert(product: product)
        cart.incert(product: product)

        XCTAssertTrue(cart.elements[product] == 2,
                      "cart after incert of a product twice should have value 2 for that product hash")
        XCTAssertTrue(cart.totalPriceInUSD == product.priceValue * 2,
                      "cart after incert of a product twice should have the totalPriceInUSD correct")
    }
}
