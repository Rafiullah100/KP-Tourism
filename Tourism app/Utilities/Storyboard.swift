//
//  Storyboard.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 04/12/21.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case destination = "Destination"
    case gallery = "Gallery"
    case mapView = "MapView"
    case POI = "POI"
    case detail = "Detail"
    case profile = "Profile"
    case visitkp = "VisitKP"

    func instantiate<T>(identifier: T.Type) -> T {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else {
            fatalError("No such view controller found")
        }
        return viewcontroller
    }
}


