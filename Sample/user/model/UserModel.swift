//
//  UserModel.swift
//  Sample
//
//  Created by ShadhIN on 26/2/25.
//
import Foundation

struct UserModel: Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
     
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
     
    init(id: String, firstName: String, lastName: String, email: String, phoneNumber: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
