//
//  Constants.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import Foundation
import UIKit
import Firebase
struct Constants {
    static let deviceType = "iOS"
    static let appColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
    
    static let enableScrolling = "enableScrolling"
    static let tableViewOffset: CGFloat = -30
    
    static var googleMapApiKey = "AIzaSyBC2Xdb2ato7ULwuGnDjPLXLAvqUZx_1VM"
    
    static var clientID = FirebaseApp.app()?.options.clientID
    
    static let lightGrayColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    static let darkGrayColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    static let blackishGrayColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 1)
    static let onlineColor = #colorLiteral(red: 0.01568627451, green: 0.8784313725, blue: 0.07450980392, alpha: 1)
    static let lightFont = UIFont(name: "Roboto-Light", size: 12.0)
    static let MediumFont = UIFont(name: "Roboto-Medium", size: 12.0)
    static let offlineColor = #colorLiteral(red: 0.7640088797, green: 0.7752518058, blue: 0.8078474402, alpha: 1)

    static let desintationArray = [Destination(image: "dest-0", title: "What to See"), Destination(image: "dest-1", title: "Getting Here"), Destination(image: "dest-2", title: "Point of Interest"), Destination(image: "dest-3", title: "Accomodation"), Destination(image: "dest-4", title: "Events"), Destination(image: "dest-5", title: "Gallery"), Destination(image: "dest-6", title: "Itinrary"), Destination(image: "dest-7", title:"Local Products")]
    
    static let section =  [Sections(title: "Home", image: "explore", selectedImage: "explore-s"),
//              Sections(title: "Attractions", image: "attraction", selectedImage: "attraction-s"),
//              Sections(title: "Adventure", image: "adventure", selectedImage: "adventure-s"),
//              Sections(title: "South KP", image: "south", selectedImage: "south-s"),
              Sections(title: "Tour Packages", image: "tour", selectedImage: "tour-s"),
              Sections(title: "Gallery", image: "gallery", selectedImage: "gallery-s"),
              Sections(title: "Archeology", image: "arch", selectedImage: "arch-s"),
              Sections(title: "Events", image: "event", selectedImage: "event-s"),
              Sections(title: "Blogs", image: "blog", selectedImage: "blog-s"),
              Sections(title: "Local Products", image: "product", selectedImage: "product-s"),
              Sections(title: "Visit KP", image: "visit-kp", selectedImage: "visit-kp"),
   ]
    
    static let slides = [Slides(image: "car", title: "Travel by car", description: "Travel by car Travel by car  Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car"), Slides(image: "car", title: "Travel by Road", description: "Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car"), Slides(image: "car", title: "Travel by Air", description: "Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car Travel by car")]
 }

enum Envoirment {
    case Test
    case Live
}

//Here setup app envoirment for TEST or LIVE
func appEnvoirment() -> Envoirment {
    return Envoirment.Test
}
