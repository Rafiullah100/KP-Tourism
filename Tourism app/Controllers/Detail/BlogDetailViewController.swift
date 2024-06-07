//
//  BlogDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit
import SDWebImage
import SVProgressHUD
class BlogDetailViewController: BaseViewController {

    @IBOutlet weak var olderCommentLabel: UILabel!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var commentTextView: UITextView!{
        didSet{
            commentTextView.delegate = self
        }
    }
    @IBOutlet weak var blogTitleLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    var blogDetail: Blog?
    var allComments: [CommentsRows] = [CommentsRows]()
    
    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.cellReuseIdentifier())
            tableView.register(UINib(nibName: "CommentReplyTableViewCell", bundle: nil), forCellReuseIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var viewCounterLabel: UILabel!
    
    var currentPage = 1
    var totalCount = 0
    var limit = 1000
    var commentText = "Write a comment"
    var likeCount = 0
    var viewsCount = 0

    var wishlistEventDetail: WishlistBlog?
    var detailType: DetailType?
    var isAllDataLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.blogModelObject = blogDetail
        scrollView.delegate = self
        scrollView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 40.0
        commentTextView.inputAccessoryView = UIView()
        commentTextView.autocorrectionType = .no
//        self.tableViewHeight.constant = self.tableView.contentSize.height
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        commentTextView.isScrollEnabled = false
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        
        if detailType == .list {
            viewControllerTitle = "\(blogDetail?.title ?? "") | Blogs"
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (blogDetail?.previewImage ?? "")))
            textView.text = blogDetail?.blogDescription.htmlToAttributedString
            blogTitleLabel.text = blogDetail?.title.stripOutHtml()
            autherLabel.text = "Author: \(blogDetail?.users.name ?? "")"
            likeLabel.text = "\(blogDetail?.likes.likesCount ?? 0) Liked"
            favoriteBtn.setImage(blogDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
            likeCount = blogDetail?.likes.likesCount ?? 0
            viewsCount = blogDetail?.viewsCounter ?? 0
            likeLabel.text = "\(String(describing: likeCount)) Liked"
            viewCounterLabel.text = "\(blogDetail?.viewsCounter ?? 0) Views"
            viewCounter(parameters: ["section_id": blogDetail?.id ?? 0, "section": "blog"])
        }
        else{
            viewControllerTitle = "\(wishlistEventDetail?.title ?? "") | Blogs"
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (wishlistEventDetail?.previewImage ?? "")))
            textView.text = wishlistEventDetail?.description?.htmlToAttributedString
            blogTitleLabel.text = wishlistEventDetail?.title?.stripOutHtml()
            autherLabel.text = "Author: \(wishlistEventDetail?.users?.name ?? "")"
            likeLabel.text = "\(wishlistEventDetail?.likesCount ?? 0) Liked"
            favoriteBtn.setImage(wishlistEventDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
            likeCount = wishlistEventDetail?.likesCount ?? 0
            viewsCount = wishlistEventDetail?.viewsCounter ?? 0
            likeLabel.text = "\(String(describing: likeCount)) Liked"
            viewCounterLabel.text = "\(wishlistEventDetail?.viewsCounter ?? 0) Views"
            viewCounter(parameters: ["section_id": wishlistEventDetail?.id ?? 0, "section": "blog"])
        }
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        favoriteBtn.isUserInteractionEnabled = Helper.shared.disableWhenNotLogin()
        reloadComment()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constant = tableView.contentSize.height
    }
    
    func viewCounter(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .viewCounter, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let viewCount):
                if viewCount.success == true {
                    guard var modelObject = DataManager.shared.blogModelObject else {
                        return
                    }
                    modelObject.viewsCounter = self.viewsCount + 1
                    DataManager.shared.blogModelObject = modelObject
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

    private func reloadComment(){
        let blogID = detailType == .list ? blogDetail?.id : wishlistEventDetail?.id
        fetchComment(parameters: ["section_id": blogID ?? 0, "section": "blog", "page": currentPage, "limit": limit])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        let description = detailType == .list ? blogDetail?.blogDescription : wishlistEventDetail?.description
        let title = detailType == .list ? blogDetail?.title : wishlistEventDetail?.title
        self.share(title: title ?? "", text: description ?? "", image: imageView.image ?? UIImage())
    }
    

    func doComment(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .doComment, method: .post, parameters: parameters, model: SuccessModel.self) { result in
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
    
    func fetchComment(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .fetchComment, method: .post,  showLoader: false, parameters: parameters, model: CommentsModel.self) { result in
            switch result {
            case .success(let comments):
                self.totalCount = comments.comments?.count ?? 1
                self.allComments.append(contentsOf: comments.comments?.rows ?? [])
                print(self.allComments)
                self.tableView.reloadData()
                self.olderCommentLabel.isHidden = self.totalCount == 0 ? true : false
                self.tableView.layoutIfNeeded() // Add this line
                self.tableViewHeight.constant = self.tableView.contentSize.height
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func loginTocomment(_ sender: Any) {
        
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        let blogID = detailType == .list ? blogDetail?.id : wishlistEventDetail?.id
        doComment(parameters: ["section_id": blogID ?? 0, "section": "blog", "comment": text])
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        let blogID = detailType == .list ? blogDetail?.id : wishlistEventDetail?.id
        self.like(parameters: ["section_id": blogID ?? 0, "section": "blog"])
    }
    
    func like(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .likeApi, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let like):
                self.favoriteBtn.setImage(like.message == "Liked" ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
                self.likeCount = like.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                self.likeLabel.text = "\(self.likeCount) Liked"
                self.changeObject()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func changeObject(){
        guard var modelObject = DataManager.shared.blogModelObject else {
            return
        }
        modelObject.likes.likesCount = self.likeCount
        modelObject.userLike = modelObject.userLike == 1 ? 0 : 1
        DataManager.shared.blogModelObject = modelObject
    }
    
    func commentReply(parameters: [String: Any], row: IndexPath) {
        dataTask = URLSession.shared.request(route: .commentReply, method: .post, parameters: parameters, model: SuccessModel.self) { result in
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
}

extension BlogDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allComments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allComments[section].replies?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let comment = allComments[indexPath.section]
        if indexPath.row == 0 {
            let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellReuseIdentifier()) as! CommentsTableViewCell
            cell.comment = comment
         
            cell.commentReplyBlock = {
                tableView.performBatchUpdates {
                    UIView.animate(withDuration: 0.3) {
                        cell.bottomView.isHidden.toggle()
                    }
                }
            }
            cell.actionBlock = { text in
                cell.textView.text = ""
                self.commentReply(parameters: ["reply": text, "comment_id": self.allComments[indexPath.section].id ?? "", "section": "blog"], row: indexPath)
                self.allComments = []
            }
            cell.textViewCellDidChangeHeight = {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            return cell
        }
        else{
            let cell: CommentReplyTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())  as! CommentReplyTableViewCell
            cell.commentReply = comment.replies?[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension BlogDetailViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.label
        }
        guard  UserDefaults.standard.isLoginned == true else { 
            textView.resignFirstResponder()
            self.view.makeToast("Login is required.", position: .center)
            return  }
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

//extension BlogDetailViewController: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
//            print(allComments.count, totalCount)
//            if allComments.count != totalCount{
//                currentPage = currentPage + 1
//                reloadComment()
//            }
//        }
//    }
//}
