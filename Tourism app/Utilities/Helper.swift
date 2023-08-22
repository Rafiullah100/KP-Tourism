//
//  Helper.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import Foundation
import UIKit
import AVFoundation
import CoreLocation
import MaterialComponents.MaterialTabs_TabBarView
import Toast_Swift
import SVProgressHUD

import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation
import Mapbox


class Helper{
    static let shared = Helper()
    
    public func slideShow(images: [String], scrollView: UIScrollView, container: UIView){
        for i in 0..<images.count {
            let offset = i == 0 ? 0 : (CGFloat(i) * container.bounds.width)
            let imgView = UIImageView(frame: CGRect(x: offset, y: 0, width: container.bounds.width, height: 263))
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleToFill
            imgView.image = UIImage(named: images[i])
            scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize(width: CGFloat(images.count) * container.bounds.width, height: 263)
    }
    
    
    public func cellSize(collectionView: UICollectionView, space: CGFloat, cellsAcross: CGFloat)-> CGSize{
//        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * space) / cellsAcross
        return CGSize(width: width, height: width)
    }
    
    func changeTab(isLoggined: Bool) -> String {
        if isLoggined == true{
            return TabName.profile.rawValue
        }
        else{
            return TabName.login.rawValue
        }
    }

    func getThumbnailImage(forUrl url: URL? = nil) -> UIImage? {
        guard let url = url else { return UIImage() }
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
    
    public func share(text: String, image: UIImage){
//        var objectsToShare = [Any]()
//        guard let imageUrl = URL(string: Route.baseUrl + (blogDetail?.thumbnailImage ?? "")) else {
//            print("Invalid url!")
//            return
//        }
//        URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
//            guard let data = data,
//                let image = UIImage(data: data) else{ return }
//            objectsToShare.append(image)
//            guard let blogDescription: String = self.blogDetail?.blogDescription else {return}
//            objectsToShare.append(blogDescription)
//            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//
//            DispatchQueue.main.async {
//                self.present(activityViewController, animated: true, completion: nil)
//            }
//        }.resume()
        
    }
    
    public func rootVC()-> UIViewController{
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        guard let rootViewController = window?.rootViewController else { return UIViewController() }
        return rootViewController
    }
    
    public func lineColor() -> UIColor{
        guard let color = UIColor(named: "lineColor") else { return UIColor() }
        return color
    }
    
    public func backgroundColor() -> UIColor{
        guard let color = UIColor(named: "backgroundColor") else { return UIColor() }
        return color
    }
    
    
    public func sectionTextColor() -> UIColor{
        guard let color = UIColor(named: "sectionTextColor") else { return UIColor() }
        return color
    }
    
    public func textColor() -> UIColor{
        guard let color = UIColor(named: "textColor") else { return UIColor() }
        return color
    }
    
    public func makepdfArray(question: String, image: String, title: String, _ inserIndex: Int){
        let item = VisitPdf(question: question, title: title, image: image)
        var array = UserDefaults.standard.pdfArray
        array?.append(item)
//        if let data: VisitPdf = try? PropertyListEncoder().encode(array) {
//            UserDefaults.standard.pdfArray = try? PropertyListEncoder().encode(data)
//        }
    }
    
    
    func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        //order of gradient colors
        gradient.colors = [UIColor.white.cgColor,UIColor.black.cgColor]
        // start and end points
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }
    
    func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        //create UIImage by rendering gradient layer.
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //get gradient UIcolor from gradient UIImage
        return UIColor(patternImage: image!)
    }
    
    
//    public func gradient(view: UIView){
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [UIColor(hex: "327425"), UIColor(hex: "084F24")]
//        view.layer.addSubview(gradientLayer)
//    }
    
//    public func showRoute(){
//        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), name: "")
//        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), name: "")
//        
//        // Set options
//        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
//        
//        // Request a route using MapboxDirections.swift
//        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let response):
//                guard let self = self else { return }
//                // Pass the first generated route to the the NavigationViewController
//                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
//                viewController.modalPresentationStyle = .fullScreen
//                self.present(viewController, animated: true, completion: nil)
//            }
//        }
//    }
    
    func getProfileImage() -> String {
        if let url = UserDefaults.standard.profileImage, url.contains("https"){
            return url
        }
        else{
            return Route.baseUrl + (UserDefaults.standard.profileImage ?? "")
        }
    }
    
    func getOtherProfileImage(urlString: String) -> String{
        print(urlString.contains("https"))
        if urlString.contains("https"){
            return urlString
        }
        else{
            return Route.baseUrl + urlString
        }
    }
    
    func disableVerticalScrolling(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 0  ||  scrollView.contentOffset.y < 0 ){
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        }
    }
    
    func customTab(tabbar: MDCTabBarView, items: [UITabBarItem], fontSize: Int? = nil) {
       tabbar.items = items
       tabbar.selectedItem = tabbar.items[0]
       tabbar.bottomDividerColor = Helper.shared.lineColor()
       tabbar.backgroundColor = Helper.shared.backgroundColor()
       tabbar.rippleColor = .clear
       tabbar.selectionIndicatorStrokeColor = #colorLiteral(red: 0.2432379425, green: 0.518629849, blue: 0.1918809414, alpha: 1)
       tabbar.preferredLayoutStyle = .scrollableCentered
       tabbar.isScrollEnabled = true
       tabbar.setTitleFont(Constants.lightFont, for: .normal)
       tabbar.setTitleFont(Constants.MediumFont, for: .selected)
       tabbar.setTitleColor(Helper.shared.sectionTextColor(), for: .normal)
       tabbar.setTitleColor(Constants.appColor, for: .selected)
       tabbar.bounces = false
       tabbar.showsVerticalScrollIndicator = false
       tabbar.alwaysBounceVertical = false
       tabbar.bouncesZoom = false
       tabbar.shouldIgnoreScrollingAdjustment = false
       tabbar.scrollsToTop = false
       tabbar.minItemWidth = 10
       tabbar.contentInsetAdjustmentBehavior = .never
    }
    
    func logoutUser(self: UIViewController) {
        UserDefaults.clean()
        UserDefaults.standard.loadFirstTime = true
        Helper.shared.changeToDefaultValue()
        Switcher.goToLoginVC(delegate: self)
        
    }
    
    func date(date: Date, formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func tableViewHeight(tableView: UITableView, tbHeight: NSLayoutConstraint) {
        tbHeight.constant = CGFloat.greatestFiniteMagnitude
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tbHeight.constant = tableView.contentSize.height
        tableView.layoutIfNeeded()
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func collectionViewHeight(collectionView: UICollectionView, cvHeight: NSLayoutConstraint) {
        cvHeight.constant = CGFloat.greatestFiniteMagnitude
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        cvHeight.constant = collectionView.contentSize.height
        collectionView.layoutIfNeeded()
    }
    
    func showMap(view: UIView, latitude: Double? = nil, longitude: Double? = nil) -> MGLMapView {
        let url = URL(string: "mapbox://styles/mapbox/streets-v12")
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude ?? Constants.kpkCoordinates.lat, longitude: longitude ?? Constants.kpkCoordinates.long), zoomLevel: 10, animated: false)
        mapView.styleURL = MGLStyle.streetsStyleURL
        mapView.tintColor = .darkGray
        return mapView
    }
    
    func locationPermission() -> CLLocationManager{
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        return locationManager
    }
    
    func loginned(_ view: UIView) {
        guard  UserDefaults.standard.isLoginned == true else {
            view.makeToast("Login is required.")
            return  }
    }
    
    func hideWhenNotLogin() -> Bool {
        return !(UserDefaults.standard.isLoginned ?? false)
    }
    
    func disableWhenNotLogin() -> Bool {
        return (UserDefaults.standard.isLoginned ?? false)
    }
    
    func isSeller() -> Bool {
        return UserDefaults.standard.isSeller == "approved" ? true : false
    }
    
    func isTourist() -> Bool {
        return UserDefaults.standard.isTourist == "approved" ? true : false
    }
    
    func attributedString(text1: String, text2: String) -> NSMutableAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "\(Constants.appFontName)-Medium", size: 18) ?? UIFont()]
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "\(Constants.appFontName)-Light", size: 12) ?? UIFont()]
        let firstString = NSAttributedString(string: text1, attributes: firstAttributes)
        let secondString = NSAttributedString(string: text2, attributes: secondAttributes)
        let thirdString = NSAttributedString(string: " ", attributes: secondAttributes)

        let concatenatedString = NSMutableAttributedString()
        concatenatedString.append(firstString)
        concatenatedString.append(thirdString)
        concatenatedString.append(secondString)
        return concatenatedString
    }
    
    func changeToDefaultValue() {
        DataManager.shared.isExploreDataLoaded = false
        DataManager.shared.isBlogDataLoaded = false
        DataManager.shared.isEventDataLoaded = false
        DataManager.shared.isPackageDataLoaded = false
        DataManager.shared.isInvestmentDataLoaded = false
        DataManager.shared.isPackageDataLoaded = false
    }
    
//    func getDirection(originCoordinate: CLLocationCoordinate2D? = nil, lat: Double? = nil, lon: Double? = nil) {
//        guard let originCoordinate = originCoordinate, let lat: Double = lat, let lon: Double = lon else { return  }
//        let origin = Waypoint(coordinate: originCoordinate, name: "")
//        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), name: "")
//
//        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
//        SVProgressHUD.show(withStatus: "Please wait...")
//        Directions(credentials: Credentials(accessToken: Constants.mapboxPublicKey)).calculate(routeOptions) { [weak self] (session, result) in
//            SVProgressHUD.dismiss()
//            switch result {
//            case .failure(let error):
//                SVProgressHUD.showError(withStatus: error.localizedDescription)
//            case .success(let response):
//                guard let self = self else { return }
//                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
//                viewController.modalPresentationStyle = .fullScreen
//                self.present(viewController, animated: true, completion: nil)
//            }
//        }
//    }
    
    
    func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            return Date()
        }
    }
    
    func dateFormate(dateString: String) -> String {
        let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let outputDateFormat = "dd MMM yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let inputDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputDateFormat
            let outputDateString = dateFormatter.string(from: inputDate)
            print(outputDateString)
            return outputDateString
        } else {
            return ""
        }
    }
}

//html text
//var attrStr = NSMutableAttributedString()
//if let data = eventDetail?.eventDescription?.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue), allowLossyConversion: true) {
//      do {
//        attrStr = try NSMutableAttributedString(
//          data: data,
//          options: [
//            NSAttributedString.DocumentReadingOptionKey.documentType:
//              NSAttributedString.DocumentType.html,
//            NSAttributedString.DocumentReadingOptionKey.characterEncoding:
//              String.Encoding.utf8.rawValue],
//          documentAttributes: nil)
////                  attrStr.addAttribute(.font, value: UIFont(name: "Poppins", size: 15.0), range: NSRange(location: 0, length: attrStr.length))
//          descriptionLabel.attributedText = attrStr
//
//      } catch {
//      }
//    }
