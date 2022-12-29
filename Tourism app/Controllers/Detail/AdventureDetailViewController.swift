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
    
    var adventureDetail: Adventure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Polo Games"
        
        titLabel.text = adventureDetail?.locationTitle
        adventureTypeLabel.text = adventureDetail?.title
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (adventureDetail?.thumbnailImage ?? "")))
        textView.text = adventureDetail?.adventureDescription
    }
}
