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
    var wishListProductDetail: WishlistLocalProduct?

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var onwerImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var likeCountLabel: UILabel!
    var likeCount = 0
    var detailType: DetailType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
       updateUI()
    }
    
    private func updateUI(){
        if detailType == .list{
            type = .backWithTitle
            viewControllerTitle = "\(productDetail?.title ?? "") | Local Products"
            thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (productDetail?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            productNameLabel.text = productDetail?.title
            descriptionTextView.text = productDetail?.localProductDescription.stripOutHtml()
            onwerImageView.sd_setImage(with: URL(string: Route.baseUrl + (productDetail?.users.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            uploadTimeLabel.text = productDetail?.createdAt
            locationLabel.text = productDetail?.districts.title
            favoriteBtn.setImage(productDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
            ownerNameLabel.text = "\(productDetail?.users.name ?? "")"
            if productDetail?.likes.count ?? 0 > 0{
                likeCount = productDetail?.likes.count ?? 0
                likeCountLabel.text = "\(String(describing: likeCount)) Liked"
            }
        }
        else{
            type = .backWithTitle
            viewControllerTitle = "\(wishListProductDetail?.title ?? "") | Local Products"
            thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (wishListProductDetail?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            productNameLabel.text = wishListProductDetail?.title
            descriptionTextView.text = wishListProductDetail?.description?.stripOutHtml()
            onwerImageView.sd_setImage(with: URL(string: Route.baseUrl + (wishListProductDetail?.users.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            uploadTimeLabel.text = wishListProductDetail?.createdAt
            locationLabel.text = wishListProductDetail?.districts.title
            favoriteBtn.setImage(wishListProductDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
            ownerNameLabel.text = "\(wishListProductDetail?.users.name ?? "")"
            if wishListProductDetail?.likes.count ?? 0 > 0{
                likeCount = wishListProductDetail?.likes.count ?? 0
                likeCountLabel.text = "\(String(describing: likeCount)) Liked"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func socialButton(_ sender: Any) {
        if detailType == .list{
            guard let uuid = productDetail?.users.uuid else { return  }
            Switcher.goToProfileVC(delegate: self, profileType: .otherUser, uuid: uuid)
        }
        else if detailType == .wishlist{
            guard let uuid = wishListProductDetail?.users.uuid else { return  }
            Switcher.goToProfileVC(delegate: self, profileType: .otherUser, uuid: uuid)
        }
        
    }

    @IBAction func shareBtnAction(_ sender: Any) {
        if detailType == .list{
            self.share(text: productDetail?.localProductDescription ?? "", image: thumbnailImageView.image ?? UIImage())
        }
        else if detailType == .wishlist{
            self.share(text: wishListProductDetail?.description ?? "", image: thumbnailImageView.image ?? UIImage())
        }
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        if detailType == .list{
            guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
            self.like(route: .likeApi, method: .post, parameters: ["section_id": productDetail?.id ?? 0, "section": "local_product"], model: SuccessModel.self)
        }
        else if detailType == .wishlist{
            guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
            self.like(route: .likeApi, method: .post, parameters: ["section_id": wishListProductDetail?.id ?? 0, "section": "local_product"], model: SuccessModel.self)
        }
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                DispatchQueue.main.async {
                    self.favoriteBtn.setImage(successDetail?.message == "Liked" ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
                    self.likeCount = successDetail?.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                    self.likeCountLabel.text = "\(self.likeCount) Liked"
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
