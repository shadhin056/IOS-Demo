//
//  UserViewController.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//

import UIKit

class UserViewController: BaseViewController {
    
    private let viewModel = UserViewModel()
    private var users: [UserModel] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
            super.viewDidLoad()
            
            setupViewModel()
            //setupTableView()
            
            DispatchQueue.global(qos: .background).async {
                self.viewModel.createUser()
            }
        }
        
        private func setupViewModel() {
            viewModel.delegate = self
        }
        
        private func setupTableView() {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        }
        
        @IBAction func onUserListViewClick(_ sender: Any) {
            LoadingUtil.shared.showLoading(on: self.view)
            viewModel.fetchAllUsers()
        }
        
        private func showEmptyStateIfNeeded() {
            if viewModel.isEmpty {
                let emptyStateLabel = UILabel()
                emptyStateLabel.text = "No users found"
                emptyStateLabel.textAlignment = .center
                emptyStateLabel.textColor = .gray
                tableView.backgroundView = emptyStateLabel
            } else {
                tableView.backgroundView = nil
            }
        }
        
        @IBAction func onBackPressed(_ sender: Any) {
            dismiss(animated: true)
        }
        
        @IBAction func deleteAllUsersTapped(_ sender: UIButton) {
            viewModel.deleteAllUsers()
        }
        
        @IBAction func createUserTapped(_ sender: UIButton) {
            viewModel.createUser()
        }
    }
 
    extension UserViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfUsers
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
                fatalError("Failed to dequeue UserTableViewCell")
            }
            let user = viewModel.user(at: indexPath.row)
            cell.configure(with: user)
            cell.delegate = self
            return cell
        }
    }
 
    extension UserViewController: UserTableViewCellDelegate {
        
        func userTableViewCell(_ cell: UserTableViewCell, didTapEmailFor user: UserModel) {
            viewModel.deleteUserById(user: user)
        }
    }
 
extension UserViewController: UserViewModelDelegate {
    func didFailToDeleteUser() {
        DispatchQueue.main.async { [weak self] in
            AlertUtil.showAlert(on: self!, title: "Error", message: "Error")
        }
    }
    
        
        func didUpdateUsers() {
            DispatchQueue.main.async { [weak self] in
                LoadingUtil.shared.hideLoading()
                self?.tableView.reloadData()
                self?.showEmptyStateIfNeeded()
            }
        }
        
        func didEncounterError(_ error: Error) {
            DispatchQueue.main.async { [weak self] in
                LoadingUtil.shared.hideLoading()
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        
        func didCreateUserSuccessfully() {
            DispatchQueue.main.async { [weak self] in
                AlertUtil.showAlert(on: self!, title: "Success", message: "Successfully created")
            }
        }
        
        func didFailToCreateUser() {
            DispatchQueue.main.async { [weak self] in
                AlertUtil.showAlert(on: self!, title: "Error", message: "Error")
            }
        }
        
        func didDeleteAllUsersSuccessfully() {
            DispatchQueue.main.async { [weak self] in
                AlertUtil.showAlert(on: self!, title: "Success", message: "Successfully Deleted")
                self?.tableView.reloadData()
                self?.showEmptyStateIfNeeded()
            }
        }
        
        func didFailToDeleteAllUsers() {
            DispatchQueue.main.async { [weak self] in
                AlertUtil.showAlert(on: self!, title: "Error", message: "Error")
            }
        }
    }
