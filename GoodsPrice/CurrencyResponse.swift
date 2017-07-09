//
//  CurrencyResponse.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

struct CurrencyResponse {
    var terms: String
    var privacy: String
    var timestamp: Int
    var source: String
    var quotes: [String: Float]

    init(terms: String, privacy: String, timestamp: Int, source: String, quotes: [String: Float]) {
        self.terms = terms
        self.privacy = privacy
        self.timestamp = timestamp
        self.source = source
        self.quotes = quotes
    }
}

extension CurrencyResponse {
    init?(json: JSONDictionary) {
        guard let terms = json["terms"] as? String,
            let privacy = json["privacy"] as? String,
            let timestamp = json["timestamp"] as? Int,
            let source = json["source"] as? String,
            let quotes = json["quotes"] as? [String: Float] else { return nil }

        self.terms = terms
        self.privacy = privacy
        self.timestamp = timestamp
        self.source = source
        self.quotes = quotes
    }
}
