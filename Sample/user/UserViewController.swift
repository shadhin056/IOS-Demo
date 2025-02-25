//
//  UserViewController.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//

import UIKit

class UserViewController: BaseViewController {
    
    private var users: [User] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            self.userCreated()
        }
        
    }
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        
    }
    
    @IBAction func onUserListViewClick(_ sender: Any) {
        LoadingUtil.shared.showLoading(on: self.view)
        
        UserManager.shared.fetchAllUsers { [weak self] users, error in
            DispatchQueue.main.async {
                LoadingUtil.shared.hideLoading()
                
                if let error = error {
                    self?.handleError(error)
                } else {
                    self?.users = users
                    self?.tableView.reloadData()
                    
                    if users.isEmpty {
                        self?.showEmptyStateIfNeeded()
                    }
                }
            }
        }
        
        
    }
    
    private func showEmptyStateIfNeeded() {
        if users.isEmpty {
            let emptyStateLabel = UILabel()
            emptyStateLabel.text = "No users found"
            emptyStateLabel.textAlignment = .center
            emptyStateLabel.textColor = .gray
            tableView.backgroundView = emptyStateLabel
        } else {
            tableView.backgroundView = nil
        }
    }
    
    private func handleError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
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
    
    @IBAction func createUserTapped(_ sender: UIButton) {
        userCreated()
    }
}
        
extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            fatalError("Failed to dequeue UserTableViewCell")
        }
        let user = users[indexPath.row]
        cell.configure(with: user)
        cell.delegate = self
        return cell
    }
}

extension UserViewController: UserTableViewCellDelegate {
    
    func userTableViewCell(_ cell: UserTableViewCell, didTapEmailFor user: User) {
        print(user.email)
    }
    
}
