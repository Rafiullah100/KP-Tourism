//
//  Storyboard.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//
import UIKit

enum Storyboard: String {
    case auth = "Auth"
    case tabs = "Tabs"
    case home = "Home"

    func instantiate<T>(identifier: T.Type) -> T {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else {
            fatalError("No such view controller found")
        }
        return viewcontroller
    }
}
