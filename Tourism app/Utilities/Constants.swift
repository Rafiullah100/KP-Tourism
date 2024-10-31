//
//  Constants.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import Foundation
import UIKit
import Firebase
import SDWebImage
struct Constants {
        
    static let tourDetail = TourDetail(area: "", experience: "", destination: "", information: "", accomodation: "")
    
    static let deviceType = "iOS"
    static let appColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
    
    static let enableScrolling = "enableScrolling"
    static let tableViewOffset: CGFloat = -30
    
    static var googleMapApiKey = "AIzaSyBC2Xdb2ato7ULwuGnDjPLXLAvqUZx_1VM"
    
    static var weatherApiKey = "y1voBGYtcqv87nEiJfQHGKVCzXQmOHiG"
    
    static var clientID = FirebaseApp.app()?.options.clientID
    
    static var kpkCoordinates = Coordinates(lat: 34.9526, long: 72.3311)
    
    static var helpline = "TEL://1422"
    static let userType = ["User", "Tourist", "Seller"]
    static let gender = ["Male", "Female", "Other"]

    static let bookingStay = "https://booking.kptourism.com/"
        static var mapboxSecretKey = "sk.eyJ1IjoidGNrcDAwNyIsImEiOiJjbGdrazJyMDkwZDd2M21xcXU5b25waW9jIn0.iOMmUGeAHWNOKKrDU5S2pg"
    
//    static var mapboxSecretKey = "sk.eyJ1IjoidGNrcDAwNyIsImEiOiJjbGU3NDA0dTgwMXdvM3BxZW1pdm9kMDljIn0.nHpmpsfGiySmMFMpQ4PxfQ"
    
    static var mapboxPublicKey = "pk.eyJ1IjoidGNrcDAwNyIsImEiOiJjbGR6cWN2YmUxNDBhM29waDRyM3B6ZHE3In0.Dz1OdPdSp56h072TorpygA"

    static var socketIOUrl = "https://staging-admin.kptourism.com?uuid=\(UserDefaults.standard.uuid ?? "")"

    static var noCoordinate = "No direction found!"
    
    static let lightGrayColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    static let darkGrayColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    static let blackishGrayColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 1)
    static let onlineColor = #colorLiteral(red: 0.01568627451, green: 0.8784313725, blue: 0.07450980392, alpha: 1)
    static let lightFont = UIFont(name: "Poppins-Light", size: 12.0)
    static let MediumFont = UIFont(name: "Poppins-Medium", size: 12.0)
    static let offlineColor = #colorLiteral(red: 0.7640088797, green: 0.7752518058, blue: 0.8078474402, alpha: 1)
    static let appFontName = "Poppins"
    static let loadFeed = "loadfeed"
    static let reloadTabbar = "reloadTabbar"
    static let loadChatUser = "chatuser"
    static let tourPlan = "loadTourPlan"

    static let socketEvent = "user-chat-message"
    static let socketTypingEvent = "is-typing"
    static let tab = 3
    
    static let desintationArray = [Destination(image: "dest-0", title: "What to See"), /*Destination(image: "dest-1", title: "Getting Here"),*/ Destination(image: "dest-2", title: "Point of Interest"), Destination(image: "dest-3", title: "Accomodation"), Destination(image: "dest-4", title: "Events"), Destination(image: "dest-5", title: "Gallery"), Destination(image: "dest-6", title: "Itinerary"), Destination(image: "dest-7", title:"Local Products"), Destination(image: "map", title: "Get Direction")]
    
    static let section =  [Sections(title: "Home", image: "explore", selectedImage: "explore-s"),
//              Sections(title: "Attractions", image: "attraction", selectedImage: "attraction-s"),
//              Sections(title: "Adventure", image: "adventure", selectedImage: "adventure-s"),
              Sections(title: "Invest in KP", image: "investment", selectedImage: "investment-s"),
              Sections(title: "Tour Packages", image: "tour", selectedImage: "tour-s"),
              Sections(title: "Gallery", image: "gallery", selectedImage: "gallery-s"),
//              Sections(title: "Archeology", image: "arch", selectedImage: "arch-s"),
              Sections(title: "Events", image: "event", selectedImage: "event-s"),
              Sections(title: "Blogs", image: "blog", selectedImage: "blog-s"),
              Sections(title: "KP Local Products", image: "product", selectedImage: "product-s"),
              Sections(title: "Visit KP", image: "visit-kp", selectedImage: "visit-kp-s"),
                           Sections(title: "Tourist Registration Form", image: "visit-kp", selectedImage: "visit-kp-s"),
   ]
    
    static let gallerySection =  [Sections(title: "Images", image: "", selectedImage: ""),
              Sections(title: "Videos", image: "", selectedImage: ""),
              Sections(title: "Virtual Tours", image: "", selectedImage: ""),
   ]
    
    static let accomodationSection =  [Sections(title: "Private Hotels", image: "", selectedImage: ""),
              Sections(title: "Camping Pods", image: "", selectedImage: ""),
              Sections(title: "Government Rest Houses", image: "", selectedImage: "")
   ]
    
    static let sampleUser =  [Sections(title: "Post", image: "", selectedImage: ""),
              Sections(title: "Blogs", image: "", selectedImage: "")
   ]
    
    static let sellerUser =  [Sections(title: "Post", image: "", selectedImage: ""),
                              Sections(title: "Blogs", image: "", selectedImage: ""),
              Sections(title: "Products", image: "", selectedImage: "")
   ]
    
    static let touristUser =  [Sections(title: "Post", image: "", selectedImage: ""),
                               Sections(title: "Blogs", image: "", selectedImage: ""),
              Sections(title: "Tour Package", image: "", selectedImage: "")
   ]
    
    static let slides = [Slides(image: "car", title: "Travel by car", description: "Travel by car Travel by car  Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car"), Slides(image: "car", title: "Travel by Road", description: "Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car"), Slides(image: "car", title: "Travel by Air", description: "Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car")]
    
    static var visitkpArray = [VisitArea(image: "north", background: "north-bg", title: "NORTH", geoTypeID: "Northern"), VisitArea(image: "midland", background: "midland-bg", title: "MIDLAND", geoTypeID: "Mid-Land"), VisitArea(image: "merged", background: "merged-bg", title: "MERGED", geoTypeID: "Merged"), VisitArea(image: "south-map", background: "south-bg", title: "SOUTH", geoTypeID: "Southern")]
    
    
    static let visitExperienceArray = [Destination(image: "river-bg", title: "RIVER"), Destination(image: "lake-bg", title: "LAKE"), Destination(image: "mountain-bg", title: "MOUNTAIN"), Destination(image: "ruins-bg", title: "RUINS"), Destination(image: "desert-bg", title: "DESERTS"), Destination(image: "hills-bg", title: "HILLS")]
    
    static let traveleInformation: [String] = ["YOUNG ADULTS", "KIDS", "SENIORS", "DISABLE (WHEELCHAIR)"]
    
    static let traveleAccomodation = [Destination(image: "resthouse", title: "GOVENMENT REST HOUSE"), Destination(image: "camping", title: "CAMPING PODS"), Destination(image: "hotel", title: "PRIVATE HOTELS"), Destination(image: "ptdc", title: "PTDC HOTELS")]
    
//    static profileImage(){
//
//    }
    
    static let priceType: [String] = ["group", "individual"]
    static let transportType: [String] = ["Public", "Personal"]
    
    static let transport: [String] = ["Motor Car", "4x4", "Bike", "Bus", "Hiace","Coaster", "Rent a Car"]
 }

enum Envoirment {
    case Test
    case Live
}

//Here setup app envoirment for TEST or LIVE
func appEnvoirment() -> Envoirment {
    return Envoirment.Test
}

enum FileType{
    case itinerary
    case personDetail
}

enum ImageType{
    case companyLicense
    case companyGuide
}
