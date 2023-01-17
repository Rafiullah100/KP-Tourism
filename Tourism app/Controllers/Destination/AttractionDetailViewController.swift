//
//  AttractionDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/16/23.
//

import UIKit

class AttractionDetailViewController: BaseViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    var attractionDistrict: AttractionsDistrict?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
    }

    func updateUI() {
        thumbnailTopLabel.text = attractionDistrict?.title
        thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
        nameLabel.text = attractionDistrict?.title
        textView.text = attractionDistrict?.description.stripOutHtml()
    }
}
