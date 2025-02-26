//
//  NewsService.swift
//  Sample
//
//  Created by ShadhIN on 26/2/25.
//
 
import Foundation
import Alamofire
 
protocol NewsServiceProtocol {
    func fetchNews(completion: @escaping (Result<NewsResponse, Error>) -> Void)
}

class NewsService: NewsServiceProtocol {
    static let shared = NewsService()
    private let apiKey = "abf87ad1f7714eaab23219ba55cf199f"
    private let baseURL = "https://newsapi.org/v2/everything"
    
    private init() {}
    
    func fetchNews(completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let parameters: [String: String] = [
            "q": "apple",
            "from": "2025-02-19",
            "to": "2025-02-19",
            "sortBy": "popularity",
            "apiKey": apiKey
        ]
        
        AF.request(baseURL, parameters: parameters).responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let newsResponse):
                completion(.success(newsResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
     
}

