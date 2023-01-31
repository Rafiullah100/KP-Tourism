//
//  BlogDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit
import SDWebImage
class BlogDetailViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var commentTextView: UITextView!{
        didSet{
            commentTextView.delegate = self
        }
    }
    @IBOutlet weak var blogTitleLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var likeLabel: UILabel!
    var blogDetail: Blog?
    var allComments: [CommentsRows] = [CommentsRows]()
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.cellReuseIdentifier())
        }
    }
    
    var currentPage = 1
    var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        
        commentTextView.text = "Message.."
        commentTextView.textColor = UIColor.lightGray
        
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = blogDetail?.title
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (blogDetail?.thumbnailImage ?? "")))
        textView.text = blogDetail?.blogDescription
        blogTitleLabel.text = blogDetail?.title
        autherLabel.text = "Author: \(blogDetail?.users.name ?? "")"
        likeLabel.text = "\(blogDetail?.likes.likesCount ?? 0) Liked"
        reloadComment()
    }
    
    private func reloadComment(){
        print(currentPage)
        fetchComment(route: .fetchComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? 0, "page": currentPage], model: CommentsModel.self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
                DispatchQueue.main.async {
                    print((comments as? CommentsModel)?.comments?.rows ?? [])
                    self.totalPages = (comments as? CommentsModel)?.comments?.count ?? 1
                    self.allComments.append(contentsOf: (comments as? CommentsModel)?.comments?.rows ?? [])
                    self.tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
                    self.tableView.reloadData()
                    self.tableView.layoutIfNeeded()
                    self.tableViewHeight.constant = self.tableView.contentSize.height
                }
            case .failure(let error):
                print(error)
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
        cell.commentLabel.text = allComments[indexPath.row].comment
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(currentPage, totalPages, indexPath.row, allComments.count-1)
        if currentPage < totalPages && indexPath.row == allComments.count-1  {
            currentPage = currentPage + 1
            reloadComment()
        }
    }
}

extension BlogDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        print("Content Height \(self.textView.contentSize.height) ")
//        if(self.textView.contentSize.height < self.textHeightConstraint.constant) {
//            self.textEntry.isScrollEnabled = false
//        } else {
//            self.textEntry.isScrollEnabled = true
//        }
//        toolBarHeight.constant = textView.contentSize.height + 20
        if text == "\n" {
            textView.resignFirstResponder()
            doComment(route: .doComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? "", "comment": textView.text ?? ""], model: SuccessModel.self)
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray || commentTextView.text == "Message.." {
            commentTextView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text.isEmpty {
            commentTextView.text = "Message.."
            commentTextView.textColor = UIColor.lightGray
        }
    }
}
