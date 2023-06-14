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
            nameLabel.text = users?.name?.capitalized
        }
    }

    @IBAction func followBtnAction(_ sender: Any) {
        self.followUser(route: .doFollow, method: .post, parameters: ["uuid": self.users?.uuid ?? ""], model: SuccessModel.self)
    }
    
    func followUser<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                let res = model as! SuccessModel
                if res.success == true {
                    self.followButton.setTitle(res.message == "Followed" ? "UNFollow" : "Follow", for: .normal)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
