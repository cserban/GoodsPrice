//
//  CorrencyProvider.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

class CorrencyProvider {
    var quotes: [String: Double] = [:]
    var httpClient: HTTPClient
    private var correncyResourceUrl: URL?
    init(httpClient: HTTPClient = HTTPClient()) {
        if let infoDictionary = Bundle.main.infoDictionary,
            let url = infoDictionary["CurrencyURL"] as? String,
            let accessKey = infoDictionary["CurrencyAccessKey"] as? String {
            correncyResourceUrl = URL(string: "\(url)live?access_key=\(accessKey)")
        }
        self.httpClient = httpClient
    }

    func loadQuates() {
        guard let correncyResourceUrl = correncyResourceUrl else { return }
        let productResource = Resource<CurrencyResponse>(url: correncyResourceUrl,
                                                         parseJSON: { anyObject in
            (anyObject as? JSONDictionary).flatMap(CurrencyResponse.init)
        })
        httpClient.load(resource: productResource, completion: ({ currencyResponse, _ in
            if let currencyResponse = currencyResponse {
                self.quotes = currencyResponse.quotes
            }
        })
        )
    }
}
