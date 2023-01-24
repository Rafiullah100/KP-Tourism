//
//  Helper.swift
//  Tourism app
//
//  Created by Rafi on 20/10/2022.
//

import Foundation
import UIKit
import AVFoundation
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
        let spaceBetweenCells: CGFloat = 2
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
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
}
