//
//  NewsExplorerViewModel.swift
//  Sample
//
//  Created by ShadhIN on 26/2/25.
//

import Foundation
 
class NewsViewModel {
    
    private let newsService: NewsServiceProtocol
    private(set) var articles: [Article] = []
     
    var onDataUpdate: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?
    
    var isLoading: Bool = false {
        didSet {
            onLoadingStatusChanged?(isLoading)
        }
    }
    
    var onLoadingStatusChanged: ((Bool) -> Void)?
    
    init(newsService: NewsServiceProtocol = NewsService.shared) {
        self.newsService = newsService
    }
    
    func fetchNews() {
        isLoading = true
        
        newsService.fetchNews { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.articles = response.articles
                self.onDataUpdate?()
                
            case .failure(let error):
                self.onErrorOccurred?(error.localizedDescription)
            }
        }
    }
     
    func numberOfArticles() -> Int {
        return articles.count
    }
    
    func article(at index: Int) -> Article {
        return articles[index]
    }
}

