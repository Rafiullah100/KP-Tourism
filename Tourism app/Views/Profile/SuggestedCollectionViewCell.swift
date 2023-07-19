//
//  SuggestedCollectionViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 5/14/23.
//

import UIKit
import SDWebImage
class SuggestedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var followAction: (() -> Void)? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var users: SuggestedUser? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.baseUrl + (users?.profileImage ?? "")))
            nameLabel.text = users?.name?.capitalized.components(separatedBy: " ").first
        }
    }

    @IBAction func followBtnAction(_ sender: Any) {
        self.followUser(parameters: ["uuid": self.users?.uuid ?? ""])
    }
    
    func followUser(parameters: [String: Any]) {
        URLSession.shared.request(route: .doFollow, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let follow):
                if follow.success == true {
                    self.followButton.setTitle(follow.message == "Followed" ? "UNFollow" : "Follow", for: .normal)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
