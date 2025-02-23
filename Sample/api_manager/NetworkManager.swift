//
//  NetworkManager.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//
// NetworkManager.swift

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = APIConfig.baseURL
    
    func request<T: Decodable>(_ request: NetworkRequest,
                              type: T.Type,
                              completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = baseURL + request.path
        
        AF.request(url,
                  method: request.method,
                  parameters: request.parameters,
                  encoding: request.encoding,
                  headers: request.headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
     
    func customRequest(_ request: NetworkRequest,
                      completion: @escaping (Result<Data, Error>) -> Void) {
        
        let url = baseURL + request.path
        
        AF.request(url,
                  method: request.method,
                  parameters: request.parameters,
                  encoding: request.encoding,
                  headers: request.headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
