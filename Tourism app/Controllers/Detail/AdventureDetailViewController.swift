//
//  AdventureDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/30/22.
//

import UIKit
import SDWebImage

class AdventureDetailViewController: BaseViewController {
    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var adventureTypeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    var adventureDetail: Adventure?
    
    @IBOutlet weak var statusBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Polo Games"
        
        titLabel.text = adventureDetail?.locationTitle
        adventureTypeLabel.text = adventureDetail?.title
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (adventureDetail?.previewImage ?? "")))
        textView.text = adventureDetail?.adventureDescription.stripOutHtml()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: adventureDetail?.adventureDescription ?? "", image: imageView.image ?? UIImage())
    }
    @IBAction func likeBtnAction(_ sender: Any) {
    }
}
