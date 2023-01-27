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

}
