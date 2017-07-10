//
//  MockURLSession.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 10/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation
@testable import GoodsPrice

class MockURLSession: URLSessionProtocol {
    var dataTask = MockURLSessionDataTask()
    var request: URLRequest?
    var data: Data?
    var error: Error?

    func dataTask( with request: URLRequest,
                   completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        self.request = request
        completionHandler(data, nil, error)
        return dataTask
    }
}
