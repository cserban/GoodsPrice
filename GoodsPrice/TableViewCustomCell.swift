//
//  TableViewCustomCell.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 12/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

class TableViewCustomCell: UITableViewCell {
    @IBOutlet weak private var productLabel: UILabel!
    @IBOutlet weak private var addView: UIView!
    @IBOutlet weak private var countLabel: UILabel!
    @IBOutlet weak private var separatorView: UIView!
    weak var theme: ThemeManager?

    func configureViewWithTheme(theme: ThemeManager) {
        self.theme = theme
        productLabel.textColor = theme.color7
        countLabel.textColor = theme.color7
        backgroundColor = theme.color1
        separatorView.backgroundColor = theme.color5.withAlphaComponent(0.10)
        refrashAddViewColor()
    }

    func configureViewFor(product: Product, cart: Cart) {
        productLabel.text = product.displayName
        setCount(count: cart.elements[product] ?? 0)
    }

    func setCount(count: Int) {
        countLabel.text = "\(count)"
        refrashAddViewColor()
    }

    func refrashAddViewColor() {
        guard let text = countLabel.text,
            let count = Int(text) else {
                return
        }
        switch count {
        case 0...3:
            addView.backgroundColor = theme?.color2
            break
        case 3...6:
            addView.backgroundColor = theme?.color4
            break
        default:
            addView.backgroundColor = theme?.color6
            break
        }
    }
}
