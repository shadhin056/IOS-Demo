//
//  RegistrationViewController.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 21/2/25.
//

import UIKit

class RegistrationViewController: BaseViewController {
    @IBOutlet var lCheck: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demo()
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    func demo(){
        let username = UserDefaultsManager.shared.getString(forKey: .username)
        lCheck.text = username
    }
}
