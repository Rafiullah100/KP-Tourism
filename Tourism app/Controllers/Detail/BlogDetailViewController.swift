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
  

    private lazy var keyboardView: KeyboardInputAccessoryView = {
        return KeyboardInputAccessoryView.view(controller: self)
    }()
    override var inputAccessoryView: UIView? {
        return keyboardView.canBecomeFirstResponder ? keyboardView : nil
    }
    override var canBecomeFirstResponder: Bool {
        return keyboardView.canBecomeFirstResponder
    }
    
    
    var currentPage = 1
    var totalCount = 1
    var limit = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollView.keyboardDismissMode = .onDrag
        scrollView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
//        customAccessoryView.delegate = self
        commentTextView.text = "Message.."
        commentTextView.textColor = UIColor.lightGray
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = blogDetail?.title
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (blogDetail?.previewImage ?? "")))
        textView.text = blogDetail?.blogDescription
        blogTitleLabel.text = blogDetail?.title
        autherLabel.text = "Author: \(blogDetail?.users.name ?? "")"
        likeLabel.text = "\(blogDetail?.likes.likesCount ?? 0) Liked"
        favoriteBtn.setImage(blogDetail?.userLike == 1 ? UIImage(named: "fav") : UIImage(named: "white-heart"), for: .normal)
        reloadComment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardView.inputTextView.resignFirstResponder()
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
                DispatchQueue.main.async {
                    if (result as? SuccessModel)?.success == true{
                        self.allComments = []
                        self.reloadComment()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchComment<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let comments):
                print((comments as? CommentsModel)?.comments.rows ?? [])
                self.totalCount = (comments as? CommentsModel)?.comments.count ?? 1
                self.allComments.append(contentsOf: (comments as? CommentsModel)?.comments.rows ?? [])
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
        self.keyboardView.showKeyboard()
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        self.like(route: .likeApi, method: .post, parameters: ["section_id": blogDetail?.id ?? 0, "section": "blog"], model: SuccessModel.self)

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

extension BlogDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellReuseIdentifier()) as! CommentsTableViewCell
        cell.comment = allComments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension BlogDetailViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !(UserDefaults.standard.isLoginned ?? false) {
            commentTextView.resignFirstResponder()
            Switcher.presentLoginVC(delegate: self)
            return
        }
        else{
            commentView.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text.isEmpty {
            commentTextView.text = "Message.."
            commentTextView.textColor = UIColor.lightGray
        }
    }
}

extension BlogDetailViewController: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
//            if allComments.count != totalCount{
//                currentPage = currentPage + 1
//                reloadComment()
//            }
//        }
//    }
}

//extension BlogDetailViewController: KeyboardInputAccessoryViewProtocol{
//    func scrollView() -> UIScrollView {
//        return UIScrollView()
//    }
//
//    func send(data type: String) {
//        doComment(route: .doComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? "", "comment": textView.text ?? ""], model: SuccessModel.self)
//    }
//
//}

extension BlogDetailViewController: KeyboardInputAccessoryViewProtocol{
//    func scrollView() -> UIScrollView {
//        return UIScrollView()
//    }
    
    func send(data type: String) {
        doComment(route: .doComment, method: .post, parameters: ["section_id": blogDetail?.id ?? "", "section": "blog", "comment": type], model: SuccessModel.self)
    }
    
    
//    func send(textView: UITextView) {
//        commentTextView.resignFirstResponder()
//        textView.resignFirstResponder()
//        commentView.isHidden = false
////        doComment(route: .doComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? "", "comment": type], model: SuccessModel.self)
//    }
}
