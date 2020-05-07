//
//  APIClient.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

public class APIClient {
    fileprivate var engine: Engine
    
    public init(engine: Engine) {
        self.engine = engine
    }
    
    public func cancelOngoingRequest() {
        engine.cancelOngoingRequest()
    }
}

public class ExchangeRateClient: APIClient {
    public func sendRequest(with endpoint: ExchangeRate, completion: @escaping (Result<Currencies, Engine.Error>) -> Void) throws {
        try engine.request(endpoint, completion: completion)
    }
}
