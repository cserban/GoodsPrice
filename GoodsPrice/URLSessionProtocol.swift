//
//  URLSessionProtocol.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Swift.Void

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
