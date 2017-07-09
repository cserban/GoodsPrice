//
//  Resource.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

enum HttpMethod: String {
    case get = "GET"
}

struct Resource<A> {
    let url: URL
    let method: HttpMethod
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, method: HttpMethod = .get, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data as Data,
                                                         options: JSONSerialization.ReadingOptions())
            return json.flatMap(parseJSON)
        }
    }
}
