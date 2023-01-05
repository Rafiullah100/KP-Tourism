//
//  ProductDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit
import SDWebImage
class ProductDetailViewController: BaseViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var uploadTimeLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    var productDetail: LocalProduct?
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var onwerImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "\(productDetail?.title ?? "") | Local Products"
        
        thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (productDetail?.thumbnailImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        productNameLabel.text = productDetail?.title
        descriptionTextView.text = productDetail?.localProductDescription
        onwerImageView.sd_setImage(with: URL(string: Route.baseUrl + (productDetail?.users.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
    }
    
    
    @IBAction func socialButton(_ sender: Any) {
    }
    

}
