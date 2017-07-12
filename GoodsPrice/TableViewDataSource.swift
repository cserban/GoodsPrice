//
//  TableViewDataSource.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 12/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var products: [Product] = []
    weak var cart: Cart?
    weak var theme: ThemeManager?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCustomCell") as? TableViewCustomCell
        if let theme = theme, let cart = cart {
            cell?.configureViewWithTheme(theme: theme)
            cell?.configureViewFor(product: products[indexPath.row], cart: cart)
        }
        return cell ?? UITableViewCell()
    }
}
