//
//  AlertUtil.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
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
    
}
