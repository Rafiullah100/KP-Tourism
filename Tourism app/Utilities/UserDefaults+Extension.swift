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
        case area
        case experience
        case destination
        case information
        case accomodation
        case theme
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
    
    var area: String? {
        get {
            string(forKey: UserDefaultsKeys.area.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.area.rawValue)
        }
    }
    
    var experience: String? {
        get {
            string(forKey: UserDefaultsKeys.experience.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.experience.rawValue)
        }
    }
    
    var destination: String? {
        get {
            string(forKey: UserDefaultsKeys.destination.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.destination.rawValue)
        }
    }
    
    var information: String? {
        get {
            string(forKey: UserDefaultsKeys.information.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.information.rawValue)
        }
    }
    
    var accomodation: String? {
        get {
            string(forKey: UserDefaultsKeys.accomodation.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.accomodation.rawValue)
        }
    }

    var theme: String? {
        get {
            string(forKey: UserDefaultsKeys.theme.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.theme.rawValue)
        }
    }
}

extension UserDefaults {
    class func clean() {
        guard let aValidIdentifier = Bundle.main.bundleIdentifier else { return }
        standard.removePersistentDomain(forName: aValidIdentifier)
        standard.synchronize()
    }
}
