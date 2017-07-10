//
//  URLSessionDataTaskProtocol.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
