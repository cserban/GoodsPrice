//
//  CartStatusView.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 12/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

class CartStatusView: NibLoadingView {
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var separatorView: UIView!
    func configureViewWithTheme(theme: ThemeManager) {
        priceLabel.textColor = theme.color8
        titleLabel.textColor = theme.color5
        setBackground(color: theme.color1)
        separatorView.backgroundColor = theme.color5.withAlphaComponent(0.10)
    }

    func priceLabel(price: Float, currencyCode: String) {
        priceLabel.text = price.toCurrencyStringWith(currencyCode: currencyCode)
    }
}
