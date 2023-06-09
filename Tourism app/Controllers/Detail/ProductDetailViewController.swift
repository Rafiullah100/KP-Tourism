//
//  ProductDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit
import SDWebImage
import SVProgressHUD
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
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var viewsCounterLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!{
        didSet{
            commentTextView.delegate = self
        }
    }
    
    var likeCount = 0
    var detailType: DetailType?
    
    var commentText = "Write a comment"
    var limit = 100
    var currentPage = 1
    var totalCount = 1
    var allComments: [CommentsRows] = [CommentsRows]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        commentTextView.inputAccessoryView = UIView()
        commentTextView.autocorrectionType = .no
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        updateUI()
        reloadComment()
    }
    
    private func updateUI(){
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        favoriteBtn.isUserInteractionEnabled = Helper.shared.disableWhenNotLogin()
        print(self.productDetail?.userLike)
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
            viewsCounterLabel.text = "\(productDetail?.viewsCounter ?? 0) Views"
            viewCounter(route: .viewCounter, method: .post, parameters: ["section_id": productDetail?.id ?? 0, "section": "local_product"], model: SuccessModel.self)
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
            viewsCounterLabel.text = "\(wishListProductDetail?.viewsCounter ?? 0) Views"
            viewCounter(route: .viewCounter, method: .post, parameters: ["section_id": wishListProductDetail?.id ?? 0, "section": "local_product"], model: SuccessModel.self)
            if wishListProductDetail?.likes.count ?? 0 > 0{
                likeCount = wishListProductDetail?.likes.count ?? 0
                likeCountLabel.text = "\(String(describing: likeCount)) Liked"
            }
        }
    }
    
    func viewCounter<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let viewCount):
                print(viewCount)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
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
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                DispatchQueue.main.async {
                    self.favoriteBtn.setImage(successDetail?.message == "Liked" ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
                    self.likeCount = successDetail?.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                    self.productDetail?.userLike = successDetail?.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                    print(self.productDetail?.userLike)
                    self.likeCountLabel.text = "\(self.likeCount) Liked"
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func reloadComment(){
        fetchComment(route: .fetchComment, method: .post, parameters: ["section_id": productDetail?.id ?? 0, "section": "local_product", "page": currentPage, "limit": limit], model: CommentsModel.self)
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        doComment(route: .doComment, method: .post, parameters: ["section_id": productDetail?.id ?? "", "section": "local_product", "comment": text], model: SuccessModel.self)
    }
    
    func doComment<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let result):
                if (result as? SuccessModel)?.success == true{
                    self.commentTextView.text = ""
                    self.allComments = []
                    self.reloadComment()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func commentReply<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, row: IndexPath) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let result):
                if (result as? SuccessModel)?.success == true{
                    self.reloadComment()
                    self.tableView.scrollToRow(at: row, at: .none, animated: false)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func fetchComment<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let comments):
                print((comments as? CommentsModel)?.comments?.rows ?? [])
                self.totalCount = (comments as? CommentsModel)?.comments?.count ?? 1
                self.allComments.append(contentsOf: (comments as? CommentsModel)?.comments?.rows ?? [])
                Helper.shared.tableViewHeight(tableView: self.tableView, tbHeight: self.tableViewHeight)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension ProductDetailViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text == "" {
            commentTextView.text = commentText
            commentTextView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == commentTextView{
            let fixedWidth = textView.frame.size.width
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            commentTextViewHeight.constant = newSize.height
            view.layoutIfNeeded()
        }
    }
    
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellReuseIdentifier()) as! CommentsTableViewCell
        cell.comment = allComments[indexPath.row]
        cell.commentReplyBlock = {
            cell.bottomView.isHidden = !cell.bottomView.isHidden
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        cell.actionBlock = { text in
            cell.textView.text = ""
            self.commentReply(route: .commentReply, method: .post, parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "local_product"], model: SuccessModel.self, row: indexPath)
            self.allComments = []
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
