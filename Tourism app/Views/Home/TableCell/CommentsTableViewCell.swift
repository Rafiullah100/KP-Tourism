//
//  CommentsTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/17/23.
//

import UIKit
import SDWebImage
class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
//    @IBOutlet weak var commentLabel: UILabel!
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
    @IBOutlet weak var replyButton: UIButton!
    
    var actionBlock: ((String) -> Void)? = nil
    var commentReplyBlock: (() -> Void)? = nil
    var inputText = "Reply"
    
    var comment: CommentsRows?{
        didSet{
            timeLabel.text = "\(comment?.createdAt ?? "")"
            commentTextView.text = "\(comment?.comment ?? "")".removeSpaces()
            nameLabel.text = "\(comment?.users?.name ?? "")".capitalized
            print(comment?.users?.profileImage ?? "")
            print(Helper.shared.getProfileImage())
            userImageView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: comment?.users?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
//            Helper.shared.tableViewHeight(tableView: tableView, tbHeight: tableViewHeight)
            tableView.reloadData()
//            tableViewHeight.constant = self.tableView.contentSize.height
            self.layoutIfNeeded()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.isHidden = true
        textView.isScrollEnabled = false
        textView.text = inputText
        textView.textColor = UIColor.lightGray
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }

    @IBAction func hideShowBtnAction(_ sender: Any) {
        self.bottomView.isHidden == true ? self.textView.becomeFirstResponder() : self.textView.resignFirstResponder()
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CommentsTableViewCell: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = inputText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        commentTextViewHeight.constant = newSize.height
        self.layoutIfNeeded()
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
