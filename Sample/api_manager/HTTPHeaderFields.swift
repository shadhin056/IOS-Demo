//
//  HTTPHeaderFields.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//

// HTTPHeaders.swift
import Alamofire

enum HTTPHeaderFields {
    case applicationJson
    case applicationJSONWithToken(String)
    case multipartFormData
    case custom([String: String])
    
    var headers: HTTPHeaders {
        switch self {
        case .applicationJson:
            return [
                APIConfig.Headers.contentType: "application/json",
                APIConfig.Headers.accept: "application/json"
            ]
            
        case .applicationJSONWithToken(let token):
            return [
                APIConfig.Headers.contentType: "application/json",
                APIConfig.Headers.accept: "application/json",
                APIConfig.Headers.authorization: "Bearer \(token)"
            ]
            
        case .multipartFormData:
            return [
                APIConfig.Headers.contentType: "multipart/form-data"
            ]
            
        case .custom(let headers):
            return HTTPHeaders(headers)
        }
    }
}
