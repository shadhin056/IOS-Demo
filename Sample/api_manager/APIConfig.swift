//
//  Untitled.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//
 
import Foundation

struct APIConfig {
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let apiKey = "39da2aad9a05908b43898af6114a7f9e"
    
    struct Endpoints {
        static let weather = "/weather"
    }
    
    struct Headers {
        static let contentType = "Content-Type"
        static let accept = "Accept"
        static let authorization = "Authorization"
        static let apiKeyHeader = "X-Api-Key"
    }
}
