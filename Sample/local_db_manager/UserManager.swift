//
//  UserManager.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 23/2/25.
//

import CoreData

class UserManager {
    static let shared = UserManager()
    private let context = CoreDataManager.shared.context
    
    private init() {}
     
    func createUser(firstName: String, lastName: String, email: String, phoneNumber: String) -> User? {
        let user = User(context: context)
        user.id = UUID().uuidString
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.phoneNumber = phoneNumber
        user.createdAt = Date()
        
        do {
            try context.save()
            return user
        } catch {
            print("Failed to create user: \(error.localizedDescription)")
            return nil
        }
    }
     
    func fetchAllUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
            return []
        }
    }
     
    func fetchUser(byId id: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
            return nil
        }
    }
     
    func deleteUser(byId id: String) -> Bool {
        guard let user = fetchUser(byId: id) else { return false }
        
        context.delete(user)
        
        do {
            try context.save()
            return true
        } catch {
            print("Failed to delete user: \(error.localizedDescription)")
            return false
        }
    }
     
    func deleteAllUsers() -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            return true
        } catch {
            print("Failed to delete all users: \(error.localizedDescription)")
            return false
        }
    }
}
