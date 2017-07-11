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
        XCTAssertTrue(cart.totalPriceUnits == 0, "cart initial price is not 0")
    }

    func testCartInitWithValidProductListAndHasCorrectCurrencyCode() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        XCTAssertNotNil(cart.currencyCode,
                        "cart initial currencyCode is not crated based on products")
        XCTAssertTrue(cart.currencyCode == "USD",
                      "cart initial currencyCode should be USD based on mock products")
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
        XCTAssertTrue(cart.totalPriceUnits == product.priceValue,
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
        XCTAssertTrue(cart.totalPriceUnits == 0,
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

        XCTAssertTrue(cart.totalPriceUnits == (productOne.priceValue + productTwo.priceValue),
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

        XCTAssertTrue(cart.totalPriceUnits == productTwo.priceValue,
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
        XCTAssertTrue(cart.totalPriceUnits == product.priceValue * 2,
                      "cart after incert of a product twice should have the totalPriceInUSD correct")
    }

    func testCartIncertNewProductThatIsNotInCart() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let product = Product(displayName: "test Product", priceValue: 1.0, currencyCode: "USD", messureUnit: "bag")
        cart.incert(product: product)

        XCTAssertTrue(cart.elements[product] == 1,
                      "cart after incert of a new product should have value 1 for that product hash")
        XCTAssertTrue(cart.totalPriceUnits == product.priceValue,
                      "cart after incert of a new product should have the totalPriceInUSD equal with the product price")
    }

    func testCartIncertProductThatRemoveProductThatIsNotInCart() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let productIncert = goodsProvider.products[0]
        cart.incert(product: productIncert)
        let product = Product(displayName: "test Product", priceValue: 1.0, currencyCode: "USD", messureUnit: "bag")
        cart.remove(product: product)

        XCTAssertNil(cart.elements[product],
                     "cart after removing a product that was not in cart should have value nil")
        XCTAssertTrue(cart.elements[productIncert] == 1,
                      "cart after incert of a product should have value 1 for that product hash")
        XCTAssertTrue(cart.totalPriceUnits == productIncert.priceValue,
                      "cart after incert of a product should have the totalPriceInUSD equal with the product price")
    }

    func testCartConvertPriceForLeftToRightConversion() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let quate = "USDEUR"
        let quateValue: Double = 2.0

        cart.totalPriceUnits = 5.0

        let convertPrice = cart.priceFor(quate: quate, quateValue: quateValue)

        XCTAssertNotNil(convertPrice, "cart convertPrice for \(quate) should compute")
        XCTAssertTrue(convertPrice == cart.totalPriceUnits * Float(quateValue),
                      "cart convertPrice for \(quate) should be 10")
    }

    func testCartConvertPriceForRightToLeftConversion() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let quate = "EURUSD"
        let quateValue: Double = 2.0

        cart.totalPriceUnits = 5.0

        let convertPrice = cart.priceFor(quate: quate, quateValue: quateValue)

        XCTAssertNotNil(convertPrice, "cart convertPrice for \(quate) should compute")
        XCTAssertTrue(convertPrice == cart.totalPriceUnits / Float(quateValue),
                      "cart convertPrice for \(quate) should be 10")
    }

    func testCartConvertPriceForInvalidQuateStringSize() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let quate = "XEURUSDX"
        let quateValue: Double = 2.0

        cart.totalPriceUnits = 5.0

        let convertPrice = cart.priceFor(quate: quate, quateValue: quateValue)

        XCTAssertNil(convertPrice, "cart convertPrice for \(quate) should fail")
    }

    func testCartConvertPriceForInvalidQuateString() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let quate = "XXXXXX"
        let quateValue: Double = 2.0

        cart.totalPriceUnits = 5.0

        let convertPrice = cart.priceFor(quate: quate, quateValue: quateValue)

        XCTAssertNil(convertPrice, "cart convertPrice for \(quate) should fail")
    }

    func testCartConvertPriceForInvalidQuateString1() {
        guard let mockProducts = MockProducts() else {
            XCTFail("mockProducts are not valid")
            return
        }
        let goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        let cart = Cart(products: goodsProvider.products)
        let quate = "XXUSDX"
        let quateValue: Double = 2.0

        cart.totalPriceUnits = 5.0

        let convertPrice = cart.priceFor(quate: quate, quateValue: quateValue)

        XCTAssertNil(convertPrice, "cart convertPrice for \(quate) should fail")
    }
}
