//
//  CollectionViewDataSource.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 12/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    weak var cart: Cart?
    weak var theme: ThemeManager?
    weak var collectionView: UICollectionView?
    var currencyProvider: CurrencyProvider
    var keys: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.invalidateIntrinsicContentSize()
                self.collectionView?.reloadData()
                self.collectionView?.selectItem(at: IndexPath(row: 0, section: 0),
                                                animated: true, scrollPosition: .left)
            }
        }
    }

    init(currencyProvider: CurrencyProvider) {
        self.currencyProvider = currencyProvider
    }

    func loadCurrency() {
        currencyProvider.loadQuates(completion: { _ in
            self.keys = Array(self.currencyProvider.quotes.keys)
        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ( !keys.isEmpty ) ? keys.count + 1 : 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuateCollectionViewCell",
                                                       for: indexPath) as? QuateCollectionViewCell

        if let theme = theme {
            if indexPath.row == 0, let defaultCurrency = currencyProvider.defaultCurrency {
                cell?.configureViewWithTheme(theme: theme, quate: defaultCurrency)
            } else {
                let quate = keys[indexPath.row - 1]
                cell?.configureViewWithTheme(theme: theme, quate: quate)
            }
        }
        return cell ?? UICollectionViewCell()
    }
}
