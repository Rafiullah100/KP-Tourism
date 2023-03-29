//
//  FeedTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/5/22.
//

import UIKit
import SDWebImage
import ExpandableLabel
class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgbgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var threeDotButton: UIButton!
    @IBOutlet weak var expandableLabel: ExpandableLabel!
    
    var actionBlock: (() -> Void)? = nil
    var shareActionBlock: (() -> Void)? = nil

    var feed: FeedModel? {
        didSet {
//            imgView.image = UIImage(named: "placeholder")
            if feed?.post?.postFiles?.count ?? 0 > 0 {
                imgbgView.isHidden = false
                imgView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.post?.postFiles?[0].imageURL ?? "").replacingOccurrences(of: " ", with: "%20")), placeholderImage: UIImage(named: "placeholder"))
            }
            else{
                imgbgView.isHidden = true
            }
            nameLabel.text = feed?.post?.users?.name
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.post?.users?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            likeCountLabel.text = "\(feed?.likesCount ?? 0)"
            timeLabel.text = "\(feed?.updatedAt ?? "")"
            commentCountLabel.text = "\(feed?.commentsCount ?? 0)"
            expandableLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")
            expandableLabel.expandedAttributedLink = NSAttributedString(string: "Read Less")
            expandableLabel.shouldCollapse = true
            expandableLabel.textReplacementType = .word
            expandableLabel.numberOfLines = 3
            expandableLabel.text = feed?.post?.description
            if UserDefaults.standard.userID ?? 0 == feed?.post?.users?.id ?? 0 {
                threeDotButton.isHidden = false
            }
            else{
                threeDotButton.isHidden = true
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
//        expandableLabel.collapsed = true
//        expandableLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareBTnAction(_ sender: Any) {
        shareActionBlock?()
    }
    @IBAction func threeDotBtnAction(_ sender: Any) {
        actionBlock?()
    }
}

extension FeedsViewController: ExpandableLabelDelegate{
    func willExpandLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = false
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            }
        }
        tableView.endUpdates()
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            }
        }
        tableView.endUpdates()
    }
}
