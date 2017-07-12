//
//  CorrencyProvider.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

class CurrencyProvider {
    var quotes: [String: Double] = [:]
    var defaultCurrency: String?
    var httpClient: HTTPClient
    private var currencyResourceUrl: URL
    init?(httpClient: HTTPClient = HTTPClient(), bundle: Bundle = Bundle.main) {
        guard let infoDictionary = bundle.infoDictionary,
            let url = infoDictionary["CurrencyURL"] as? String,
            let accessKey = infoDictionary["CurrencyAccessKey"] as? String,
            let currencyResourceUrl = URL(string: "\(url)live?access_key=\(accessKey)") else { return nil }
        self.currencyResourceUrl = currencyResourceUrl
        self.httpClient = httpClient
    }

    func loadQuates(completion: @escaping (Bool) -> Void) {
        let productResource = Resource<CurrencyResponse>(url: currencyResourceUrl,
                                                         parseJSON: { anyObject in
            (anyObject as? JSONDictionary).flatMap(CurrencyResponse.init)
        })
        httpClient.load(resource: productResource, completion: ({ currencyResponse, error in
            if let currencyResponse = currencyResponse {
                self.quotes = currencyResponse.quotes
                self.defaultCurrency = currencyResponse.source
                completion(true)
            } else if error != nil {
                completion(false)
            } else {
                completion(false)
            }
        })
        )
    }
}
