//
//  Constants.swift
//  Tourism app
//
//  Created by Rafi on 27/10/2022.
//

import Foundation
import UIKit

//enum PaymentMethod {
//    case walletPayment
//    case cashOnDelivery
//    case machinePayment
//    case stcPayment
//    case creditCardPayment
//}

struct PaymentMethod {
    let name: String
    let description: String
    let point: Int
    let icon: String
    let navigateTo: Bool
}

struct Constants {
    
    static let paymentMethod = [PaymentMethod(name: "Wallet Points", description: "Use the wallet points", point: 50, icon: "wallet-payment", navigateTo: false), PaymentMethod(name: "Cash On Delivery", description: "Cash on delivery", point: -1, icon: "cash-on-delivery", navigateTo: false),
     PaymentMethod(name: "Machine Payment", description: "Machine payment", point: -1, icon: "machine-payment", navigateTo: false), PaymentMethod(name: "STC Pay", description: "STC pay", point: -1, icon: "stc", navigateTo: true), PaymentMethod(name: "Credit/Debit Card", description: "Credit/Debit Card", point: -1, icon: "credit-payment", navigateTo: true)]

    static let days = {
        if UserDefaults.standard.languageCode == "ar"{
            return ["الأحد", "الاثنين", "الثلاثاء", "الأربعاء", "الخميس", "الجمعة", "السبت"]
        }
        else{
            return ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        }
    }()
    
    static let menu = {
        if UserDefaults.standard.languageCode == "ar"{
            return [
                settingData(text: "عربتي", icon: "cart"),
                settingData(text: "قائمة الرغبات", icon: "wish-list"),
                settingData(text: "اللغة / الإنجليزية", icon: "language"),
                settingData(text: "ملاحظات العملاء", icon: "Star"),
                settingData(text: "مشاركة التطبيق", icon: "share"),
                settingData(text: "الشروط والأحكام", icon: "error"),
                settingData(text: "اتصل بنا", icon: "message-call")
            ]
            
        }
        else{
            return [settingData(text: "My Cart", icon: "cart"),
                                settingData(text: "Wishlist", icon: "wish-list"),
                                settingData(text: "Language  / English", icon: "language"),
                                settingData(text: "Customer Feedback", icon: "Star"),
                                settingData(text: "Share App", icon: "share"),
                                settingData(text: "Terms and Condions", icon: "error"),
                                settingData(text: "Contact Us", icon: "message-call")
            ]
        }
    }()
    
    static let appColor = #colorLiteral(red: 0.9682764411, green: 0.6770070195, blue: 0.4894526005, alpha: 1)
    static let fontName = "Cairo"
    static let fontNameBold = "Cairo-Bold"
    static let fontRegular = "Cairo-Regular"
    static let fontNameMedium = "Cairo-Medium"
    static let fontNameSemoBold = "Cairo-Semibold"

    static let appMediumFont = UIFont(name: "Cairo-Medium", size: 10.0)

    static let appBoldFont = UIFont(name: "Cairo-bold", size: 12.0)
    static let appRegularFont = UIFont(name: "Cairo", size: 12.0)
    static let errorMessage = "Something went wrong!"
    static let newsSection = ["Latest", "Politics", "Financial", "Sports", "SciTech", "Entertainment", "Health", "Tourism", "Blend"]
    
    static let opanionSection = ["Hasan Nisar", "Hamid Mir", "Aftab Iqbal", "Hasan Nisar", "Hasan Nisar"]
    
    static let source = [ "• haraj.com.sa.",
   "• Noon.com.",
   "• aliexpress.com.",
   "• amazon.sa",
   "• opensooq.com.",
   "• Jarir",
   "• Extra.com",
   "• Alshaya",
   "• Eddy",
   "• Nahdionline.com",
   "• Namshi.com.",
   "• Mercado Libre",
   "• Amazon.ae",
   "• Jazp",
   "• Ebay",
   "• Walmart",
   "• Target Corporation",
   "• Best Buy",
   "• Rakuten",
   "• Newegg",
   "• Carrefour",
   "• Cobone",
   "• Lulu Hypermarket",
   "• Ounass",
   "• Tamimi Markets",
   "• Ubuy",
   "• Xcite",
   "• Extrastores.com",
   "• Alibaba.com",
   "• Markavip.com",
    ]
    
    static let rtl = 1
    static let ltr = 0
    static let selectedTabbarIndex = 2
    static let notificationName = "reloadData"
    
    static let aboutQaaren = "<div style=\"text-align: center; font-weight: regular; font-size: 18px; line-height: 1.5;><h1>Welcome to Qareen</h1><p>Saudi's independent price comparison service with over 1000 products. Qaaren's ambition is to offer consumers a fantastic service.You can rest assured that we are always on your side as a consumer in the online jungle of retailers and products. We love what we do and are incredibly proud to help people make wise decisions and save a lot of money – every day of the year. Qaaren brings great offers every day – compare prices and offers from over 100 retailers. We keep the prices updated on daily basis. When a consumer compares specific products and prices, they are normally close to making a purchase. So Qaaren's visitors have a high level of willingness to act and buy.</p></div>"
    
}
