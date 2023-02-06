//
//  TravelViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/13/23.
//

import UIKit
import SDWebImage
struct Slides {
    let image: String?
    let title: String?
    let description: String?
}

class TravelCollectionViewCell: UICollectionViewCell {
    //
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var slide: GettingHere?{
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (slide?.imageURL ?? "")))
            label.text = slide?.title
            textView.text = slide?.description.stripOutHtml()
        }
    }
}

class TravelViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    var currentPage = 0
    
    var gettingArray: [GettingHere]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if currentPage < (gettingArray?.count ?? 0) - 1{
            currentPage = currentPage + 1
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
        }
    }
    @IBAction func preBtn(_ sender: Any) {
        if currentPage != 0 {
            currentPage = currentPage - 1
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
        }
    }
}

extension TravelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gettingArray?.count ?? 0
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! TravelCollectionViewCell
        cell.slide = gettingArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
