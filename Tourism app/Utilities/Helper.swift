//
//  Helper.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import Foundation
import UIKit
import AVFoundation
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation
import MaterialComponents.MaterialTabs_TabBarView

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
        Switcher.goToLoginVC(delegate: self)
    }
    
    func date(date: Date, formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

