//
//  Webservice.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

class HTTPClient {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func load<A>(resource: Resource<A>, completion: @escaping (A?, Error?) -> Void) {
        let request = URLRequest(resource: resource)
        session.dataTask(with: request) { data, _, error in
            completion(data.flatMap(resource.parse), error)
        }.resume()
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request,
                         completionHandler: completionHandler) as URLSessionDataTask)
            as URLSessionDataTaskProtocol
    }
}
