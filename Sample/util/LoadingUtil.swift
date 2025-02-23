//
//  LoadingUtil.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//

import UIKit

class LoadingUtil {
    static let shared = LoadingUtil()
    private init() {}
    
    private var loadingView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    func showLoading(on view: UIView) {
        hideLoading()
        
        loadingView = UIView(frame: view.bounds)
        loadingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.center = loadingView!.center
        activityIndicator?.color = .white
        
        loadingView?.addSubview(activityIndicator!)
        view.addSubview(loadingView!)
        
        activityIndicator?.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator?.stopAnimating()
        loadingView?.removeFromSuperview()
        loadingView = nil
        activityIndicator = nil
    }
}
