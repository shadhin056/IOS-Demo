//
//  NewsTableViewCell.swift
//  Sample
//
//  Created by ShadhIN on 26/2/25.
//

import UIKit
import Alamofire

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    @IBOutlet var txtTitle: UILabel!
    @IBOutlet var txtDescription: UILabel!
      
    override func awakeFromNib() {
        super.awakeFromNib()
    }
     
    private func setupUI() {
        
    }
    
    func configure(with article: Article) {
        txtTitle.text = article.title
        txtDescription.text = article.description
         
        // Load image if available
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            //newsImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(systemName: "newspaper"))
        } else {
            //newsImageView.image = UIImage(systemName: "newspaper")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //newsImageView.af.cancelImageRequest()
        //newsImageView.image = nil
    }
}
