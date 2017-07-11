//
//  StringExtension.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 11/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

extension String {
    func startIndexOfSubstriong(substring: String) -> Int? {
        guard let lowerBound = self.lowercased().range(of: substring.lowercased())?.lowerBound else {
                return nil
        }
        return self.distance(from: self.startIndex, to: lowerBound)
    }
}
