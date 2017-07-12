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
    @IBOutlet weak private var clearButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var collectionView: UICollectionView!

    var tableViewDataSource: TableViewDataSource?
    var tableViewDelegate: TableViewDelegate?
    var collectionViewDataSource: CollectionViewDataSource?
    var goodsProvider: GoodsProvider?
    var currencyProvider: CurrencyProvider?
    private var observerContext = 0
    @objc var cart: Cart?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = themeManager.color1
        initTableView()
        initGoodsProvider()
        initCurrencyProvider()
        initCollectionView()
        initCart()
        tableView.reloadData()
        collectionViewDataSource?.loadCurrency()
        clearButton.setTitleColor(themeManager.color6, for: .normal)
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

    func initCurrencyProvider() {
        guard let currencyProvider = CurrencyProvider() else {
            return
        }
        self.currencyProvider = currencyProvider
    }

    func initCollectionView() {
        guard let currencyProvider = currencyProvider else {
            return
        }
        collectionViewDataSource = CollectionViewDataSource(currencyProvider: currencyProvider)
        collectionViewDataSource?.theme = themeManager
        collectionViewDataSource?.collectionView = collectionView
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        collectionView.backgroundColor = themeManager.color1
    }

    func initCart() {
        cart = Cart(products: goodsProvider?.products ?? [])
        addObserver(self, forKeyPath: #keyPath(cart.totalPriceUnits), options: [.old, .new], context: &observerContext)
        tableViewDataSource?.cart = cart
        tableViewDelegate?.cart = cart
    }

    @IBAction func clearCartAction(_ sender: Any) {
        removeObserver(self, forKeyPath: #keyPath(cart.totalPriceUnits))
        cart = nil
        initCart()
        tableView.reloadData()
        if let indexPathForSelectedCollectionCell = collectionView.indexPathsForSelectedItems?.first {
            collectionView.deselectItem(at: indexPathForSelectedCollectionCell, animated: true)
        }
        collectionViewDataSource?.loadCurrency()
        refrashTotalPrice()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(cart.totalPriceUnits) {
            refrashTotalPrice()
        }
    }

    func refrashTotalPrice() {
        guard let cart = cart,
            let currency = currencyProvider?.defaultCurrency else { return }
        if collectionView.indexPathsForSelectedItems?.first?.row == 0 {
            cartStatusView.priceLabel(price: cart.totalPriceUnits, currencyCode: currency)
        } else if let selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row {
            if let currencyCode = collectionViewDataSource?.keys[selectedIndex - 1],
                let conversionValue = currencyProvider?.quotes[currencyCode],
                let cartPriceInCurrency = cart.priceFor(quate: currencyCode, quateValue: conversionValue) {
                cartStatusView.priceLabel(price: cartPriceInCurrency, currencyCode: currencyCode)
            }
        } else {
            cartStatusView.priceLabel(price: 0.0, currencyCode: "USD")
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        refrashTotalPrice()
    }
}
