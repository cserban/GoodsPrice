//
//  TableViewDelegate.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 12/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    var products: [Product] = []
    weak var cart: Cart?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cart?.incert(product: products[indexPath.row])
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
