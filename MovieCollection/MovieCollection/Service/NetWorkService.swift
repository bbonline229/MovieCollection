//
//  NetworkService.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL
}

class NetWorkService {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
            }
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                completion(result)
            } catch {
                print(error)
                completion(nil)
            }
            }.resume()
    }
}
