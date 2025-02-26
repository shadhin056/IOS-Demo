//
//  UserDefaultsManager.swift
//  Sample
//
//  Created by ShadhIN  
//

// UserDefaultsManager.swift

import Foundation

enum UserDefaultsKeys: String, CaseIterable {
    case username
    case isLoggedIn
    case appTheme
    case lastOpenedDate
    case userPreferences
    case notificationSettings
}

class UserDefaultsManager {
    // Singleton instance
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
      
    func save<T>(_ value: T, forKey key: UserDefaultsKeys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getValue<T>(forKey key: UserDefaultsKeys) -> T? {
        return defaults.object(forKey: key.rawValue) as? T
    }
    
    func removeValue(forKey key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func clearAll() {
        UserDefaultsKeys.allCases.forEach { removeValue(forKey: $0) }
    }
      
    func saveString(_ value: String, forKey key: UserDefaultsKeys) {
        save(value, forKey: key)
    }
    
    func getString(forKey key: UserDefaultsKeys) -> String? {
        return getValue(forKey: key)
    }
    
    func saveBool(_ value: Bool, forKey key: UserDefaultsKeys) {
        save(value, forKey: key)
    }
    
    func getBool(forKey key: UserDefaultsKeys) -> Bool {
        return getValue(forKey: key) ?? false
    }
    
    func saveInt(_ value: Int, forKey key: UserDefaultsKeys) {
        save(value, forKey: key)
    }
    
    func getInt(forKey key: UserDefaultsKeys) -> Int {
        return getValue(forKey: key) ?? 0
    }
    
    func saveDouble(_ value: Double, forKey key: UserDefaultsKeys) {
        save(value, forKey: key)
    }
    
    func getDouble(forKey key: UserDefaultsKeys) -> Double {
        return getValue(forKey: key) ?? 0.0
    }
      
    func saveObject<T: Encodable>(_ object: T, forKey key: UserDefaultsKeys) {
        if let encoded = try? JSONEncoder().encode(object) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    func getObject<T: Decodable>(forKey key: UserDefaultsKeys, type: T.Type) -> T? {
        if let data = defaults.data(forKey: key.rawValue) {
            return try? JSONDecoder().decode(type, from: data)
        }
        return nil
    }
    
    func saveArray<T: Encodable>(_ array: [T], forKey key: UserDefaultsKeys) {
        if let encoded = try? JSONEncoder().encode(array) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    func getArray<T: Decodable>(forKey key: UserDefaultsKeys, type: T.Type) -> [T]? {
        if let data = defaults.data(forKey: key.rawValue) {
            return try? JSONDecoder().decode([T].self, from: data)
        }
        return nil
    }
    
    func saveDictionary<T: Encodable>(_ dict: [String: T], forKey key: UserDefaultsKeys) {
        if let encoded = try? JSONEncoder().encode(dict) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    func getDictionary<T: Decodable>(forKey key: UserDefaultsKeys, type: T.Type) -> [String: T]? {
        if let data = defaults.data(forKey: key.rawValue) {
            return try? JSONDecoder().decode([String: T].self, from: data)
        }
        return nil
    }
}
