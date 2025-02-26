//
//  UserViewModel.swift
//  Sample
//
//  Created by ShadhIN on 26/2/25.
//
//
//  UserViewModel.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 26/2/25.
//

import Foundation

protocol UserViewModelDelegate: AnyObject {
    func didUpdateUsers()
    func didEncounterError(_ error: Error)
    func didCreateUserSuccessfully()
    func didFailToCreateUser()
    func didDeleteAllUsersSuccessfully()
    func didFailToDeleteAllUsers()
    func didFailToDeleteUser()
}

class UserViewModel {
    private(set) var usersModel: [UserModel] = []
    weak var delegate: UserViewModelDelegate?
    
    func fetchAllUsers() {
            UserManager.shared.fetchAllUsers { [weak self] users, error in
                if let error = error {
                    self?.delegate?.didEncounterError(error)
                } else {
                    self?.usersModel = users.map { user in
                        return UserModel(
                            id: user.id  ?? "",
                            firstName: user.firstName ?? "",
                            lastName: user.lastName ?? "",
                            email: user.email ?? "",
                            phoneNumber: user.phoneNumber ?? ""
                        )
                    }
                    
                    self?.delegate?.didUpdateUsers()
                }
            }
    }
    
    func deleteUserById(user : UserModel) -> Bool{
        let isSuccess = UserManager.shared.deleteUser(byId: user.id)
        
        if isSuccess {
            fetchAllUsers()
        }else{
            delegate?.didFailToDeleteUser()
        }
        
        return isSuccess
    }
    
    func createUser() {
        if let _ = UserManager.shared.createUser(
            firstName: "John",
            lastName: "Doe",
            email: "john@example.com",
            phoneNumber: "1234567890"
        ) {
            delegate?.didCreateUserSuccessfully()
        } else {
            delegate?.didFailToCreateUser()
        }
    }
    
    func deleteAllUsers() {
        if UserManager.shared.deleteAllUsers() {
            usersModel.removeAll()
            delegate?.didDeleteAllUsersSuccessfully()
        } else {
            delegate?.didFailToDeleteAllUsers()
        }
    }
    
    var isEmpty: Bool {
        return usersModel.isEmpty
    }
    
    func user(at index: Int) -> UserModel {
        return usersModel[index]
    }
    
    var numberOfUsers: Int {
        return usersModel.count
    }
}
