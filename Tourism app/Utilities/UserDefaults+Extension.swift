//
//  UserDefaults+Extension.swift
//  Yummie
//
//  Created by rafi ullah on 07/08/2021.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case accessToken
        case isLoginned
        case userID
        case userEmail
        case name
        case districtKey
        case area
        case attraction
        case destination
        case information
        case accomodation
        case theme
        case profileImage
        case uuid
        case userType
        case userBio
        case pdfArray
        case otpEmail
        case isSeller
        case isTourist
        case loadFirstTime
        case notificationStatus
        case appleSigninIdentifier
        case appleEmail
        case appleName
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
    
    var loadFirstTime: Bool? {
        get {
            bool(forKey: UserDefaultsKeys.loadFirstTime.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.loadFirstTime.rawValue)
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
    
    var name: String? {
        get {
            string(forKey: UserDefaultsKeys.name.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.name.rawValue)
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
    
    var attraction: Int? {
        get {
            integer(forKey: UserDefaultsKeys.attraction.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.attraction.rawValue)
        }
    }
    
    var destination: Int? {
        get {
            integer(forKey: UserDefaultsKeys.destination.rawValue)
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
    
    var accomodation: Int? {
        get {
            integer(forKey: UserDefaultsKeys.accomodation.rawValue)
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
    
    var profileImage: String? {
        get {
            string(forKey: UserDefaultsKeys.profileImage.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.profileImage.rawValue)
        }
    }
    
    var uuid: String? {
        get {
            string(forKey: UserDefaultsKeys.uuid.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.uuid.rawValue)
        }
    }
    
    var userType: String? {
        get {
            string(forKey: UserDefaultsKeys.userType.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.userType.rawValue)
        }
    }
    
    var isSeller: String? {
        get {
            string(forKey: UserDefaultsKeys.isSeller.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.isSeller.rawValue)
        }
    }
    
    var isTourist: String? {
        get {
            string(forKey: UserDefaultsKeys.isTourist.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.isTourist.rawValue)
        }
    }
    
    var userBio: String? {
        get {
            string(forKey: UserDefaultsKeys.userBio.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.userBio.rawValue)
        }
    }
    
    var pdfArray: [VisitPdf]? {
        get {
            array(forKey: UserDefaultsKeys.pdfArray.rawValue) as? [VisitPdf]
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.pdfArray.rawValue)
        }
    }
    
    var otpEmail: String? {
        get {
            string(forKey: UserDefaultsKeys.otpEmail.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.otpEmail.rawValue)
        }
    }
    
    var notificationStatus: Bool? {
        get {
            bool(forKey: UserDefaultsKeys.notificationStatus.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.notificationStatus.rawValue)
        }
    }
    
    var appleSigninIdentifier: String?  {
        get {
            value(forKey: UserDefaultsKeys.appleSigninIdentifier.rawValue) as? String
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.appleSigninIdentifier.rawValue)
        }
    }
    
    var appleEmail: String?  {
        get {
            value(forKey: UserDefaultsKeys.appleEmail.rawValue) as? String
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.appleEmail.rawValue)
        }
    }
    
    var appleName: String?  {
        get {
            value(forKey: UserDefaultsKeys.appleName.rawValue) as? String
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.appleName.rawValue)
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
//
//
//class SharedDataModel {
//    static let shared = SharedDataModel()
//    var sharedData: [ExploreDistrict]?
//}
