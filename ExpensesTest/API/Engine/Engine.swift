//
//  ExchangeRate.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

private let Key = "67f7e72b3da52513a9a2d03e4b0d871b"

public struct Engine {
    public indirect enum Error: Swift.Error {
        case badBaseUrl
        case badUrl
        case noData
        case apiRequestLimitReached
        case requestFailedWithStatusCode(Int)
        case requestFailedWithError(Swift.Error)
        case decodeFailedWithError(Swift.Error)
    }
    
    private let environment: Environment
    private var dataTask: URLSessionDataTask?
    
    public init(environment: Environment) {
        self.environment = environment
    }
    
    func cancelOngoingRequest() {
        dataTask?.cancel()
    }
    
    mutating public func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) throws {
        let urlRequest = try makeRequest(with: endpoint)
        dataTask = try makeDataTask(with: urlRequest, completion: completion)
        dataTask?.resume()
    }
    
    private func makeRequest(with endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(string: environment.baseUrl) else {
            throw Error.badBaseUrl
        }
        
        components.path = "/" + endpoint.path
        
        var parameters = endpoint.parameters ?? [String: String]()
        parameters["access_key"] = Key
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            throw Error.badUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.string
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    private func makeDataTask<T: Decodable>(with urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) throws -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailedWithError(error)))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            guard (200 ..< 300) ~= response.statusCode else {
                completion(.failure(self.parse(statusCode: response.statusCode)))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("Decode failed with error: \(error.localizedDescription)")
                completion(.failure(.decodeFailedWithError(error)))
            }
        }
    }
    
    private func parse(statusCode: Int) -> Error {
        switch statusCode {
            case 104:
                return Error.apiRequestLimitReached
            default:
                return Error.requestFailedWithStatusCode(statusCode)
        }
    }
}
