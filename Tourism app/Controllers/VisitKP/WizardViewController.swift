//
//  WizardViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/14/23.
//

import UIKit
import SDWebImage
class WizardViewController: BaseViewController {

    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var visitDetail: VisitKPRow?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .back1
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (visitDetail?.previewImage ?? "")))
        titLabel.text = visitDetail?.title
        descriptionLabel.text = visitDetail?.description
    }
}
