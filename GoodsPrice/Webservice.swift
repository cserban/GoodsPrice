//
//  Webservice.swift
//  GoodsPrice
//
//  Created by Serban Chiricescu on 09/07/2017.
//  Copyright © 2017 cserban. All rights reserved.
//

import Foundation

struct Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> Void) {
        let request = URLRequest(resource: resource)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            completion(data.flatMap(resource.parse))
        }.resume()
    }
}
