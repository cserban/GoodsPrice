//
//  ViewController.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 06/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var themeManager = ThemeManager()

    @IBOutlet weak private var topStatusBarView: UIView! {
        didSet {
            topStatusBarView.backgroundColor = themeManager.color3
        }
    }
    @IBOutlet weak private var cartStatusView: CartStatusView! {
        didSet {
            cartStatusView.configureViewWithTheme(theme: themeManager)
        }
    }
    @IBOutlet weak private var tableView: UITableView!
    var tableViewDataSource: TableViewDataSource?
    var tableViewDelegate: TableViewDelegate?
    var goodsProvider: GoodsProvider?
    private var observerContext = 0
    @objc var cart: Cart?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = themeManager.color1
        initTableView()
        initGoodsProvider()
        initCart()
        tableView.reloadData()
    }

    deinit {
        removeObserver(self, forKeyPath: #keyPath(cart.totalPriceUnits))
    }

    func initTableView() {
        tableViewDataSource = TableViewDataSource()
        tableViewDelegate = TableViewDelegate()
        tableViewDataSource?.theme = themeManager
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.backgroundColor = themeManager.color1
        let nib = UINib(nibName: "TableViewCustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCustomCell")
    }

    func initGoodsProvider() {
        guard let mockProducts = MockProducts() else {
            return
        }
        goodsProvider = GoodsProvider(mockProducts: mockProducts.productsArray)
        tableViewDataSource?.products = goodsProvider?.products ?? []
        tableViewDelegate?.products = goodsProvider?.products ?? []
    }

    func initCart() {
        cart = Cart(products: goodsProvider?.products ?? [])
        addObserver(self, forKeyPath: #keyPath(cart.totalPriceUnits), options: [.old, .new], context: &observerContext)
        tableViewDataSource?.cart = cart
        tableViewDelegate?.cart = cart
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(cart.totalPriceUnits) {
            guard let cart = cart else { return }
            cartStatusView.priceLabel(price: cart.totalPriceUnits, currencyCode: cart.currencyCode ?? "")
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
