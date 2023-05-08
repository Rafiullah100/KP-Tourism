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
    
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.cellReuseIdentifier())
        }
    }
    
    var currentPage = 1
    var totalCount = 1
    var limit = 100
    var commentText = "Write a comment"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        self.tableViewHeight.constant = self.tableView.contentSize.height
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "blogs"
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (blogDetail?.previewImage ?? "")))
        textView.text = blogDetail?.blogDescription.stripOutHtml()
        blogTitleLabel.text = blogDetail?.title.stripOutHtml()
        autherLabel.text = "Author: \(blogDetail?.users.name ?? "")"
        likeLabel.text = "\(blogDetail?.likes.likesCount ?? 0) Liked"
        favoriteBtn.setImage(blogDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
        reloadComment()
    }

    private func reloadComment(){
        fetchComment(route: .fetchComment, method: .post, parameters: ["section_id": blogDetail?.id ?? 0, "section": "blog", "page": currentPage, "limit": limit], model: CommentsModel.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: blogDetail?.blogDescription ?? "", image: imageView.image ?? UIImage())
    }
    
    func doComment<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let result):
                if (result as? SuccessModel)?.success == true{
                    self.allComments = []
                    self.reloadComment()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
                self.tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
                self.tableViewHeight.constant = self.tableView.contentSize.height
                self.tableView.layoutIfNeeded()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func loginTocomment(_ sender: Any) {
        guard let text = textView.text, !text.isEmpty else { return }
        doComment(route: .doComment, method: .post, parameters: ["section_id": blogDetail?.id ?? "", "section": "blog", "comment": text], model: SuccessModel.self)
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        self.like(route: .likeApi, method: .post, parameters: ["section_id": blogDetail?.id ?? 0, "section": "blog"], model: SuccessModel.self)

    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                self.favoriteBtn.setImage(successDetail?.message == "Liked" ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension BlogDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellReuseIdentifier()) as! CommentsTableViewCell
        cell.comment = allComments[indexPath.row]
        cell.actionBlock = { text in
            cell.textView.text = ""
            self.commentReply(route: .commentReply, method: .post, parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "blog"], model: SuccessModel.self, row: indexPath)
            self.allComments = []
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension BlogDetailViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text == "" {
            commentTextView.text = commentText
            commentTextView.textColor = UIColor.lightGray
        }
    }
}
