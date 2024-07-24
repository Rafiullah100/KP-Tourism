//
//  PostCommentViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/3/23.
//

import UIKit
import SVProgressHUD
class PostCommentViewController: BaseViewController {


    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.cellReuseIdentifier())
            tableView.register(UINib(nibName: "CommentReplyTableViewCell", bundle: nil), forCellReuseIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var commentTextView: UITextView!{
        didSet{
            commentTextView.delegate = self
        }
    }
    
    var commentText = "Write a comment"
    var limit = 500
    var currentPage = 1
    var totalCount = 1
    var allComments: [CommentsRows] = [CommentsRows]()
    var postId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        reloadComment()
    }

    
    private func reloadComment(){
        fetchComment(parameters: ["section_id": postId ?? 0, "section": "post", "page": currentPage, "limit": limit])
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        doComment(parameters: ["section_id": postId ?? 0, "section": "post", "comment": text])
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
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
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

    func fetchComment(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .fetchComment, method: .post, parameters: parameters, model: CommentsModel.self) { result in
            switch result {
            case .success(let commentsDetail):
                self.totalCount = commentsDetail.comments?.count ?? 1
                self.allComments.append(contentsOf: commentsDetail.comments?.rows ?? [])
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}


extension PostCommentViewController: UITextViewDelegate{
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
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == commentTextView{
            let fixedWidth = textView.frame.size.width
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            textViewHeight.constant = newSize.height
            view.layoutIfNeeded()
        }
    }
}

extension PostCommentViewController: UITableViewDelegate, UITableViewDataSource{
    
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
                        cell.layoutIfNeeded() // Ensure layout is updated
                    }
                }
            }
            cell.actionBlock = { text in
                cell.textView.text = ""
                self.commentReply(parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "post"], row: indexPath)
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if allComments.count != totalCount && indexPath.row == allComments.count - 1  {
//            currentPage = currentPage + 1
//            reloadComment()
//        }
//    }
}
