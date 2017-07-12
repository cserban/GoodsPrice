//
//  QuateCollectionViewCell.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 12/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import UIKit

class QuateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var quateLabel: UILabel!
    @IBOutlet weak private var view: UIView!
    weak var theme: ThemeManager?

    func configureViewWithTheme(theme: ThemeManager, quate: String) {
        self.theme = theme
        view.backgroundColor = theme.color1
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        if quate.characters.count > 3 {
            let startIndex = quate.index(quate.startIndex, offsetBy: 3)
            quateLabel.text = quate.substring(from: startIndex)
        } else {
            quateLabel.text = quate

        }
        setUIforSelectionState(selected: isSelected)
    }

    override var isSelected: Bool {
        didSet {
            setUIforSelectionState(selected: isSelected)
        }
    }

    func setUIforSelectionState(selected: Bool) {
        if selected {
            quateLabel.textColor = theme?.color7
            quateLabel.font = UIFont(name: "Avenir-Heavy", size: 19)
        } else {
            quateLabel.textColor = theme?.color5
            quateLabel.font = UIFont(name: "Avenir-Book", size: 17)
        }
    }

}
