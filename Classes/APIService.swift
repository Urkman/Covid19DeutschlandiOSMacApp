//
//  APIService.swift
//  covid19
//
//  Created by Stefan Sturm on 16.12.19.
//

import Foundation

class APIService {
    func get<T:Decodable>(_ url: URL, completion: @escaping (Result<T, Error>) -> ()) {
        print(url.absoluteURL)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")

        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                return completion(.failure(error))
            }

            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            }

            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()

                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }

        }.resume()
    }
}
