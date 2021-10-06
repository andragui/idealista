//
//  GenericServiceCall.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 5/10/21.
//

import Foundation

class GenericServiceCall {
    class func makeServiceCall<T: Codable>(withUrl url: String, andCodableObject type: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let specificUrl = URL(string: url)!
        var urlRequest = URLRequest(url: specificUrl)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let data = data, error == nil {
                let jsonDecoder = JSONDecoder()
                if let results = try? jsonDecoder.decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(.success(results))
                    }
                }
            } else if let _ = error {}
        }.resume()
    }
}
