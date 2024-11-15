//
//  Userdefaults.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/12/24.
//

import Foundation

extension UserDefaults{
    enum userdefaultsKey: String {
        case selectedLanguage
        case isRTL
        case languageCode
    }
    
    var selectedLanguage: String?  {
        get {
            value(forKey: userdefaultsKey.selectedLanguage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.selectedLanguage.rawValue)
        }
    }
    
    var isRTL: Int?  {
        get {
            value(forKey: userdefaultsKey.isRTL.rawValue) as? Int
        }
        set {
            set(newValue, forKey: userdefaultsKey.isRTL.rawValue)
        }
    }
    
    var languageCode: String?  {
        get {
            value(forKey: userdefaultsKey.languageCode.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.languageCode.rawValue)
        }
    }
}
