//
//  UserDefaults+Extension.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 07/08/2021.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case accessToken
        case isLoginned
        case userID
        case userEmail
        case districtKey

    }
    
    var accessToken: String? {
        get {
            value(forKey: UserDefaultsKeys.accessToken.rawValue) as? String
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.accessToken.rawValue)
        }
    }
    
    var isLoginned: Bool? {
        get {
            bool(forKey: UserDefaultsKeys.isLoginned.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.isLoginned.rawValue)
        }
    }
    
    var userID: Int? {
        get {
            integer(forKey: UserDefaultsKeys.userID.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.userID.rawValue)
        }
    }
    
    var userEmail: String? {
        get {
            string(forKey: UserDefaultsKeys.userEmail.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.userEmail.rawValue)
        }
    }
    
    var districtKey: Int? {
        get {
            integer(forKey: UserDefaultsKeys.districtKey.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.districtKey.rawValue)
        }
    }

}
