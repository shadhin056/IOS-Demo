//
//  NewsExplorerViewController.swift
//  Sample
//
//  Created by ShadhIN on 26/2/25.
//

import UIKit

class NewsExplorerViewController : BaseViewController {
      
    @IBOutlet var newsTableview: UITableView!
    
    private let viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchNews()
    }
   
    private func setupUI() {
         
    }
   
    private func setupBindings() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.newsTableview.reloadData()
                self?.newsTableview.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onErrorOccurred = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.newsTableview.refreshControl?.endRefreshing()
                AlertUtil.showAlert(title: "Error",message: errorMessage,from: self!)
            }
        }
        
        viewModel.onLoadingStatusChanged = { [weak self] isLoading in
            DispatchQueue.main.async {
                guard let view = self?.view else { return }
                if isLoading {
                    LoadingUtil.shared.showLoading(on: view)
                } else {
                    LoadingUtil.shared.hideLoading()
                }
            }
        }
    }
    
    @objc private func refreshData() {
        viewModel.fetchNews()
    }
    
}
extension NewsExplorerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let article = viewModel.article(at: indexPath.row)
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
} 
