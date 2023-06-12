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
    
    @IBOutlet weak var verfiedIcon: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    var actionBlock: (() -> Void)? = nil
    var shareActionBlock: (() -> Void)? = nil
    var saveActionBlock: (() -> Void)? = nil
    var commentActionBlock: (() -> Void)? = nil

    
    private var feed: FeedModel?
    var likeButtonTappedHandler: (() -> Void)?
    var wishlistButtonTappedHandler: (() -> Void)?

    func configure(feed: FeedModel) {
        self.feed = feed
        likeButton.setImage(feed.isLiked == 1 ? UIImage(named: "post-like") : UIImage(named: "like-black"), for: .normal)
        saveButton.setImage(feed.isWished == 1 ? UIImage(named: "save-icon-red") : UIImage(named: "save-icon"), for: .normal)
        
//            imgView.image = UIImage(named: "placeholder")
        if feed.post?.post_files?.count ?? 0 > 0 {
            imgbgView.isHidden = false
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (feed.post?.post_files?[0].image_url ?? "").replacingOccurrences(of: " ", with: "%20")), placeholderImage: UIImage(named: "placeholder"))
        }
        else{
            imgbgView.isHidden = true
        }
        nameLabel.text = feed.post?.users?.name?.capitalized
        if let url = feed.post?.users?.profile_image, url.contains("https://") {
            userImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()))
        }
        else{
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (feed.post?.users?.profile_image ?? "")), placeholderImage: UIImage(named: "user"))
        }
        
        verfiedIcon.isHidden = true
        
        if feed.post?.users?.isSeller == "approved"{
            verfiedIcon.isHidden = false
            verfiedIcon.image = UIImage(named: "verified-seller")
        }
        else if feed.post?.users?.isTourist == "approved"{
            verfiedIcon.isHidden = false
            verfiedIcon.image = UIImage(named: "verified-tourist")
        }
        else{
            verfiedIcon.isHidden = true
            verfiedIcon.image = UIImage(named: "")
        }
                            
        likeCountLabel.text = "\(feed.likesCount ?? 0)"
        timeLabel.text = "\(feed.updatedAt ?? "")"
        commentCountLabel.text = "\(feed.commentsCount ?? 0)"
        expandableLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")
        expandableLabel.expandedAttributedLink = NSAttributedString(string: "Read Less")
        expandableLabel.shouldCollapse = true
        expandableLabel.textReplacementType = .word
        expandableLabel.numberOfLines = 3
        expandableLabel.text = feed.post?.description
        if UserDefaults.standard.userID ?? 0 == feed.post?.users?.id ?? 0 {
            threeDotButton.isHidden = false
        }
        else{
            threeDotButton.isHidden = true
        }
    }
    
//    var feed: FeedModel? {
//        didSet {
//            likeButton.setImage(feed?.isLiked == 1 ? UIImage(named: "post-like") : UIImage(named: "like-black"), for: .normal)
//            saveButton.setImage(feed?.isWished == 1 ? UIImage(named: "save-icon-red") : UIImage(named: "save-icon"), for: .normal)
//
////            imgView.image = UIImage(named: "placeholder")
//            if feed?.post?.post_files?.count ?? 0 > 0 {
//                imgbgView.isHidden = false
//                imgView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.post?.post_files?[0].image_url ?? "").replacingOccurrences(of: " ", with: "%20")), placeholderImage: UIImage(named: "placeholder"))
//            }
//            else{
//                imgbgView.isHidden = true
//            }
//            nameLabel.text = feed?.post?.users?.name?.capitalized
//            if let url = feed?.post?.users?.profile_image, url.contains("https://") {
//                userImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()))
//            }
//            else{
//                userImageView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.post?.users?.profile_image ?? "")), placeholderImage: UIImage(named: "user"))
//            }
//
//            verfiedIcon.isHidden = true
//
//            if feed?.post?.users?.isSeller == "approved"{
//                verfiedIcon.isHidden = false
//                verfiedIcon.image = UIImage(named: "verified-seller")
//            }
//            else if feed?.post?.users?.isTourist == "approved"{
//                verfiedIcon.isHidden = false
//                verfiedIcon.image = UIImage(named: "verified-tourist")
//            }
//            else{
//                verfiedIcon.isHidden = true
//                verfiedIcon.image = UIImage(named: "")
//            }
//
//            likeCountLabel.text = "\(feed?.likesCount ?? 0)"
//            timeLabel.text = "\(feed?.updatedAt ?? "")"
//            commentCountLabel.text = "\(feed?.commentsCount ?? 0)"
//            expandableLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")
//            expandableLabel.expandedAttributedLink = NSAttributedString(string: "Read Less")
//            expandableLabel.shouldCollapse = true
//            expandableLabel.textReplacementType = .word
//            expandableLabel.numberOfLines = 3
//            expandableLabel.text = feed?.post?.description
//            if UserDefaults.standard.userID ?? 0 == feed?.post?.users?.id ?? 0 {
//                threeDotButton.isHidden = false
//            }
//            else{
//                threeDotButton.isHidden = true
//            }
//        }
//    }
//
    
    

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
    @IBAction func saveBtnAction(_ sender: Any) {
        self.wishList(route: .doWishApi, method: .post, parameters: ["section_id": self.feed?.id ?? 0, "section": "post"], model: SuccessModel.self)
    }
    
    @IBAction func likeBtnAAction(_ sender: Any) {
        self.like(route: .likeApi, method: .post, parameters: ["section_id": self.feed?.id ?? 0, "section": "post"], model: SuccessModel.self)
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                self.likeButton.setImage(successDetail?.message == "Liked" ? UIImage(named: "post-like") : UIImage(named: "like-black"), for: .normal)
                var count = self.feed?.likesCount ?? 0
                if successDetail?.message == "Liked"{
                    count = count + 1
                }
                else{
                    count = count - 1
                }
                self.likeCountLabel.text = "\(count)"
                self.likeButtonTappedHandler?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func wishList<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                self.saveButton.setImage(successDetail?.message == "Wishlist Added" ? UIImage(named: "save-icon-red") : UIImage(named: "save-icon"), for: .normal)
                self.wishlistButtonTappedHandler?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func commentBtnAction(_ sender: Any) {
        commentActionBlock?()
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
