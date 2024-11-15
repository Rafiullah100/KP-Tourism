//
//  ProductGalleryViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/10/24.
//

import UIKit

class ProductGalleryViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var buttonView: UIView!
    var scrollView: UIScrollView!
        var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView(frame: view.bounds)
        imageView = UIImageView(image: UIImage(named: "grocerapp-home-care-624d28c2bc37b copy 1.svg"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = scrollView.bounds
        
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        view.addSubview(scrollView)
        
        view.bringSubviewToFront(self.buttonView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imageView
        }
    

    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
}
