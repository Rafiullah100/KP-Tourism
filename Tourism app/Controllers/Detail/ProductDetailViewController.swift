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

    @IBOutlet weak var olderCommentLabel: UILabel!
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
    var viewsCount = 0

    var commentText = "Write a comment"
    var limit = 1000
    var currentPage = 1
    var totalCount = 0
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
        if detailType == .list{
            DataManager.shared.productModelObject = productDetail
            type = .backWithTitle
            viewControllerTitle = "\(productDetail?.title ?? "") | Local Products"
            thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (productDetail?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            productNameLabel.text = productDetail?.title
            descriptionTextView.text = productDetail?.localProductDescription.stripOutHtml().removeSpaces()
            onwerImageView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: productDetail?.users.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            uploadTimeLabel.text = productDetail?.createdAt
            locationLabel.text = productDetail?.districts.title
            favoriteBtn.setImage(productDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
            ownerNameLabel.text = "\(productDetail?.users.name ?? "")"
            viewsCounterLabel.text = "\(productDetail?.viewsCounter ?? 0) Views"
            viewCounter(parameters: ["section_id": productDetail?.id ?? 0, "section": "local_product"])
            if productDetail?.likes.count ?? 0 > 0{
                likeCount = productDetail?.likes[0].likesCount ?? 0
                likeCountLabel.text = "\(String(describing: likeCount)) Liked"
            }
            viewsCount = productDetail?.viewsCounter ?? 0
        }
        else{
            type = .backWithTitle
            viewControllerTitle = "\(wishListProductDetail?.title ?? "") | Local Products"
            thumbnailImageView.sd_setImage(with: URL(string: Route.baseUrl + (wishListProductDetail?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            productNameLabel.text = wishListProductDetail?.title
            descriptionTextView.text = wishListProductDetail?.description?.stripOutHtml().removeSpaces()
            onwerImageView.sd_setImage(with: URL(string: Route.baseUrl + (wishListProductDetail?.users?.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            uploadTimeLabel.text = wishListProductDetail?.createdAt
            locationLabel.text = wishListProductDetail?.districts.title
            favoriteBtn.setImage(wishListProductDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
            ownerNameLabel.text = "\(wishListProductDetail?.users?.name ?? "")"
            viewsCounterLabel.text = "\(wishListProductDetail?.viewsCounter ?? 0) Views"
            viewCounter(parameters: ["section_id": wishListProductDetail?.id ?? 0, "section": "local_product"])
            if wishListProductDetail?.likes?.count ?? 0 > 0{
                likeCount = wishListProductDetail?.likes?[0].likesCount ?? 0
                likeCountLabel.text = "\(String(describing: likeCount)) Liked"
            }
            viewsCount = wishListProductDetail?.viewsCounter ?? 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constant = tableView.contentSize.height
    }
    
    func viewCounter(parameters: [String: Any]) {
        URLSession.shared.request(route: .viewCounter, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let viewCount):
                if viewCount.success == true {
                    guard var modelObject = DataManager.shared.productModelObject else {
                        return
                    }
                    modelObject.viewsCounter = self.viewsCount + 1
                    DataManager.shared.productModelObject = modelObject
                }
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
            guard let uuid = wishListProductDetail?.users?.uuid else { return  }
            Switcher.goToProfileVC(delegate: self, profileType: .otherUser, uuid: uuid)
        }
        
    }

    @IBAction func shareBtnAction(_ sender: Any) {
        if detailType == .list{
            self.share(title: productDetail?.title ?? "", text: productDetail?.localProductDescription ?? "", image: thumbnailImageView.image ?? UIImage())
        }
        else if detailType == .wishlist{
            self.share(title: wishListProductDetail?.title ?? "", text: wishListProductDetail?.description ?? "", image: thumbnailImageView.image ?? UIImage())
        }
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        if detailType == .list{
            guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
            self.like(parameters: ["section_id": productDetail?.id ?? 0, "section": "local_product"])
        }
        else if detailType == .wishlist{
            guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
            self.like(parameters: ["section_id": wishListProductDetail?.id ?? 0, "section": "local_product"])
        }
    }
    
    func like(parameters: [String: Any]) {
        URLSession.shared.request(route: .likeApi, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let like):
                if like.success == true {
                    self.favoriteBtn.setImage(like.message == "Liked" ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
                    self.likeCount = like.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                    self.productDetail?.userLike = like.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                    self.likeCountLabel.text = "\(self.likeCount) Liked"
                    self.changeObject()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func changeObject(){
        guard var modelObject = DataManager.shared.productModelObject else {
            return
        }
        modelObject.likes[0].likesCount = self.likeCount
        modelObject.userLike = modelObject.userLike == 1 ? 0 : 1
        DataManager.shared.productModelObject = modelObject
    }
    
    private func reloadComment(){
        let productID = detailType == .list ? productDetail?.id : wishListProductDetail?.id
        fetchComment(parameters: ["section_id": productID ?? 0, "section": "local_product", "page": currentPage, "limit": limit])
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        let productID = detailType == .list ? productDetail?.id : wishListProductDetail?.id
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        doComment(parameters: ["section_id": productID ?? "", "section": "local_product", "comment": text])
    }
    
    func doComment(parameters: [String: Any]) {
        URLSession.shared.request(route: .doComment, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let result):
                if result.success == true{
                    self.commentTextView.text = ""
                    self.allComments = []
                    self.reloadComment()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

    func commentReply(parameters: [String: Any], row: IndexPath) {
        URLSession.shared.request(route: .commentReply, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let result):
                if result.success == true{
                    self.reloadComment()
                    self.tableView.scrollToRow(at: row, at: .none, animated: false)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

    func fetchComment(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchComment, method: .post,  showLoader: false, parameters: parameters, model: CommentsModel.self) { result in
            switch result {
            case .success(let comments):
                self.totalCount = comments.comments?.count ?? 1
                self.allComments.append(contentsOf: comments.comments?.rows ?? [])
                self.tableView.reloadData()
                self.olderCommentLabel.isHidden = self.totalCount == 0 ? true : false
//                Helper.shared.tableViewHeight(tableView: self.tableView, tbHeight: self.tableViewHeight)
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
            tableView.performBatchUpdates {
                UIView.animate(withDuration: 0.3) {
                    cell.bottomView.isHidden.toggle()
                }
            }
        }
        cell.actionBlock = { text in
            cell.textView.text = ""
            self.commentReply(parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "local_product"], row: indexPath)
            self.allComments = []
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
