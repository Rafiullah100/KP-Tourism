//
//  Utilities.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/18/23.
//

import Foundation
import UIKit
class Utility {
    static func showAlert(title:String = "", message:String, buttonTitles:[String], completion: @escaping (_ responce: String) -> Void) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        for btnTitle in buttonTitles{
            let action = UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: { action in
                completion(btnTitle)
            })
           alertController.addAction(action)
        }

        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    static func actionSheet(title:String = "", message:String, buttonTitles:[String], completion: @escaping (_ responce: String) -> Void) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for btnTitle in buttonTitles{
            if btnTitle == "Cancel"{
                let action = UIAlertAction(title: btnTitle, style: UIAlertAction.Style.cancel, handler: { action in
                    completion(btnTitle)
                })
                actionSheet.addAction(action)
            }
            else{
                let action = UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: { action in
                    completion(btnTitle)
                })
                actionSheet.addAction(action)
            }
        }
        UIApplication.topViewController()?.present(actionSheet, animated: true)
    }
}
