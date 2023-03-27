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
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var onwerImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var statusBarView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "\(productDetail?.title ?? "") | Local Products"
        
        thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (productDetail?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        productNameLabel.text = productDetail?.title
        descriptionTextView.text = productDetail?.localProductDescription
        onwerImageView.sd_setImage(with: URL(string: Route.baseUrl + (productDetail?.users.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        uploadTimeLabel.text = productDetail?.createdAt
        locationLabel.text = productDetail?.districts.title
        favoriteBtn.setImage(productDetail?.userLike == 1 ? UIImage(named: "fav") : UIImage(named: "white-heart"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
    }
    
    @IBAction func socialButton(_ sender: Any) {
    }
    

    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: productDetail?.localProductDescription ?? "", image: thumbnailImageView.image ?? UIImage())
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        self.like(route: .likeApi, method: .post, parameters: ["section_id": productDetail?.id ?? 0, "section": "local_product"], model: SuccessModel.self)
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                DispatchQueue.main.async {
                    self.favoriteBtn.setImage(successDetail?.message == "Liked" ? UIImage(named: "fav") : UIImage(named: "white-heart"), for: .normal)

                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
