//
//  URLRequestExtension.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

extension URLRequest {
    init<A>(resource: Resource<A>) {
        self.init(url: resource.url as URL)
        httpMethod = resource.method.rawValue
    }
}
