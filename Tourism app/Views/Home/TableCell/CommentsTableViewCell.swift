//
//  CommentsTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/17/23.
//

import UIKit
import SDWebImage
class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentReplyTableViewCell", bundle: nil), forCellReuseIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())
        }
    }
 
    var comment: CommentsRows?{
        didSet{
            timeLabel.text = "\(comment?.createdAt ?? "")"
            commentLabel.text = "\(comment?.comment ?? "")"
            nameLabel.text = "\(comment?.users.name ?? "")"
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (comment?.users.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            
            self.tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableViewHeight.constant = self.tableView.contentSize.height
            self.tableView.layoutIfNeeded()
        }
    }
    
//    override var intrinsicContentSize: CGSize{
//        self.layoutIfNeeded()
//        return tableView.contentSize
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CommentsTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment?.replies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentReplyTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())  as! CommentReplyTableViewCell
        cell.commentReply = comment?.replies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
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

//final class DynamicHeightTableView: UITableView {
//    override var contentSize:CGSize {
//        didSet {
//            invalidateIntrinsicContentSize()
//        }
//    }
//    override var intrinsicContentSize: CGSize {
//        layoutIfNeeded()
//        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
//    }
//}
