//
//  CommentsTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/17/23.
//

import UIKit
import SDWebImage
class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView.delegate = self
        }
    }
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentReplyTableViewCell", bundle: nil), forCellReuseIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())
        }
    }
    
    var actionBlock: ((String) -> Void)? = nil
    var commentReplyBlock: (() -> Void)? = nil
    var inputText = "Reply"
    
    var comment: CommentsRows?{
        didSet{
            timeLabel.text = "\(comment?.createdAt ?? "")"
            commentLabel.text = "\(comment?.comment ?? "")"
            nameLabel.text = "\(comment?.users?.name ?? "")"
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (comment?.users?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            self.tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableViewHeight.constant = self.tableView.contentSize.height
            self.tableView.layoutIfNeeded()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tableViewHeight.constant = self.tableView.contentSize.height
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.text = inputText
        textView.textColor = UIColor.lightGray
    }

    @IBAction func hideShowBtnAction(_ sender: Any) {
        commentReplyBlock?()
    }
    @IBAction func replyButtonAction(_ sender: Any) {
        guard let text = textView.text, !text.isEmpty, text != inputText else { return }
        actionBlock?(text)
    }
}

extension CommentsTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment?.replies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentReplyTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())  as! CommentReplyTableViewCell
        cell.commentReply = comment?.replies?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewHeight.constant = tableView.contentSize.height
    }
}

extension CommentsTableViewCell: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = inputText
            textView.textColor = UIColor.lightGray
        }
    }
}

class DynamicHeightTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
