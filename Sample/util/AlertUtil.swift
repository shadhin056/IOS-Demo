//
//  AlertUtil.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN  
//

import UIKit

class AlertUtil {
    
    static func showAlert(on viewController: UIViewController,
                          title: String,
                          message: String,
                          preferredStyle: UIAlertController.Style = .alert,
                          actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)]) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(title: String,
                      message: String,
                      from viewController: UIViewController,
                      completion: (() -> Void)? = nil) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            })
            
            DispatchQueue.main.async {
                viewController.present(alert, animated: true)
            }
        }
}
