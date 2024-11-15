//
//  Helper.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//

import Foundation
import UIKit

public class Helper{
    static let shared = Helper()
    
    func dateFormate(dateString: String) -> String {
        let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let outputDateFormat = "MMM d, yyyy, h:mm a"
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.locale = Locale(identifier: "en_PK")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Parse the input as UTC time

        if let inputDate = dateFormatter.date(from: dateString) {
            
            dateFormatter.dateFormat = outputDateFormat
            dateFormatter.timeZone = TimeZone.current
            let outputDateString = dateFormatter.string(from: inputDate)
            
            print(outputDateString)
            return outputDateString
        } else {
            return ""
        }
    }
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        var formattedString = ""
        
        let maxLength = min(phoneNumber.count, 10)
        
        for (index, digit) in phoneNumber.prefix(maxLength).enumerated() {
            if index == 0 {
                formattedString += "0"
            } else if index == 1 {
                formattedString += "5"
            } else if index == 2 {
                formattedString += String(digit) + " "
            } else if index == 5 {
                formattedString += String(digit) + " "
            } else {
                formattedString += String(digit)
            }
        }
        return formattedString
    }
    
    func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "yyyy-MM-dd"
        let myStringDate = formatter.string(from: yourDate!)
        return myStringDate
    }
    
    func convertTo24HourFormat(time12: String) -> String? {
        print(time12)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"

        if let date = dateFormatter.date(from: time12) {
            dateFormatter.dateFormat = "HH:mm:ss" // Format for 24-hour time with minutes
            return dateFormatter.string(from: date)
        } else {
            return nil // Return nil if the input is invalid
        }
    }
    
    func semantic(_ language: AppLanguage) -> UISemanticContentAttribute{
//        let language: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .arabic
        print(language)
        switch language {
        case .english:
            return .forceLeftToRight
        case .arabic:
            return .forceRightToLeft
        }
    }
    
    func isRTL() -> Bool{
        return UserDefaults.standard.isRTL == 1 ? true : false
    }
}



