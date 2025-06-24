//
//  APIService.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 14/06/25.
//

import Foundation

struct APIResponse: Decodable {
    
}

class APIService {
    
    func fetch(with stringUrl: String, completion: @escaping(Result<APIResponse, Error>) -> Void) {
        guard let url = URL(string: stringUrl) else  { return }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(decoder))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(URLError(.badURL)))
            }
        }
        session.resume()
    }
    
    // Genric
    func fetchData<T: Decodable>(with uRLString: String, type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: uRLString) else { return }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoder))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(URLError(.badURL)))
            }
        }
        session.resume()
    }
}
