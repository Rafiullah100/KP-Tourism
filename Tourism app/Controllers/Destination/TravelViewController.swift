//
//  TravelViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/13/23.
//

import UIKit

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
    
    var slide: Slides?{
        didSet{
            imgView.image = UIImage(named: slide?.image ?? "")
            label.text = slide?.title
            textView.text = slide?.description
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
    
    let slides = Constants.slides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if currentPage < slides.count - 1{
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
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! TravelCollectionViewCell
        cell.slide = slides[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
