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
    
}

