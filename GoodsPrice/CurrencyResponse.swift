//
//  CurrencyResponse.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

struct CurrencyResponse {
    var success: Bool
    var terms: String
    var privacy: String
    var timestamp: Int
    var source: String
    var quotes: [String: Double]

    init(success: Bool, terms: String, privacy: String, timestamp: Int, source: String, quotes: [String: Double]) {
        self.success = success
        self.terms = terms
        self.privacy = privacy
        self.timestamp = timestamp
        self.source = source
        self.quotes = quotes
    }
}

extension CurrencyResponse {
    init?(json: JSONDictionary) {
        guard let success = json["success"] as? Bool,
            let terms = json["terms"] as? String,
            let privacy = json["privacy"] as? String,
            let timestamp = json["timestamp"] as? Int,
            let source = json["source"] as? String,
            let quotes = json["quotes"] as? [String: Double] else { return nil }
        self.success = success
        self.terms = terms
        self.privacy = privacy
        self.timestamp = timestamp
        self.source = source
        self.quotes = quotes
    }
}
