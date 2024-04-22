//
//  Service.swift
//  Movie
//
//  Created by Thibault Ballof on 17/04/2024.
//

import Foundation

protocol Networking {
    func fetch<T: Decodable>(type: T.Type) async throws -> T
}

class Service: Networking {
    let baseURL = URL(string: ApiEndpoints.BaseURL.moviesBaseUrl + "api_key=edef578eed4cd92a64fa40066ad4020b")!
    
    
    func fetch<T: Decodable>(type: T.Type) async throws -> T {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        do {
            let (data, error) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let responseData = try decoder.decode(T.self, from: data)
            
            return responseData
            
        } catch {
            throw NetworkError.requestFailed
        }
    }
}


class MockService: Networking {
    func fetch<T: Decodable>(type: T.Type) async throws -> T {
        var dataMocked: Data? {
            let bundle = Bundle(for: MockService.self)
            let url = bundle.url(forResource: "MockData", withExtension: ".json")!
            return try? Data(contentsOf: url)
        }
        
        let decoder = JSONDecoder()
        guard let dataMocked else { throw NetworkError.invalidData }
        let responseData = try decoder.decode(T.self, from: dataMocked)
        
        return responseData
    }
    
    
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}



