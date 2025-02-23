//
//  UserViewController.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//

import UIKit

class UserViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        DispatchQueue.global(qos: .background).async {
            self.userCreated()
        }

    }
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    func userCreated() {
        if let newUser = UserManager.shared.createUser(
            firstName: "John",
            lastName: "Doe",
            email: "john@example.com",
            phoneNumber: "1234567890"
        ) {
            DispatchQueue.main.async {
                AlertUtil.showAlert(on: self,title: "Success",message: "Successfully created")
            }
        } else {
            DispatchQueue.main.async {
                AlertUtil.showAlert(on: self,title: "Error",message: "Error")
            }
        }
    }
    @IBAction func createUserTapped(_ sender: UIButton) {
        userCreated()
       }
       
       @IBAction func fetchUsersTapped(_ sender: UIButton) {
           LoadingUtil.shared.showLoading(on: self.view)
           let users = UserManager.shared.fetchAllUsers()
       }
       
    @IBAction func deleteAllUsersTapped(_ sender: UIButton){
     
           if UserManager.shared.deleteAllUsers() {
               DispatchQueue.main.async {
                   AlertUtil.showAlert(on: self,title: "Success",message: "Successfully Deleted")
               }
           } else {
               DispatchQueue.main.async {
                   AlertUtil.showAlert(on: self,title: "Error",message: "Error")
               }
           }
       }
       
func fetchByIdTapped(_ sender: UIButton) {
             
           let users = UserManager.shared.fetchAllUsers()
           
           if let firstUserId = users.first?.id,
              let user = UserManager.shared.fetchUser(byId: firstUserId) {
               DispatchQueue.main.async {
                   AlertUtil.showAlert(on: self,title: "Success",message: "Successfully Fetched User")
               }
           } else {
               DispatchQueue.main.async {
                   AlertUtil.showAlert(on: self,title: "Error",message: "Error")
               }
           }
       }

}
