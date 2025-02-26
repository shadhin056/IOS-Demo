//
//  BaseViewController.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN  
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
    @objc func dismissKeyboard() {
            view.endEditing(true)
    }

}
