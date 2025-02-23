//
//  NetworkRequest.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//
// NetworkRequest.swift
import Alamofire

protocol NetworkRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

extension NetworkRequest {
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        return HTTPHeaderFields.applicationJson.headers
    }
}
