//
//  EventDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit
import SDWebImage
class EventDetailViewController: BaseViewController {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interestGoingLabel: UILabel!
    
    var eventDetail: EventListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Events"
        titLabel.text = eventDetail?.title
        eventTypeLabel.text = eventDetail?.locationTitle
        descriptionLabel.text = eventDetail?.eventDescription?.stripOutHtml()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (eventDetail?.thumbnailImage ?? "")))
        if eventDetail?.socialEventUsers?.count != 0 {
            interestGoingLabel.text = "\(eventDetail?.socialEventUsers?[0].userCount ?? 0) Interested"
        }
        if eventDetail?.isExpired == "Closed" {
            statusView.backgroundColor = .red
        }
        else{
            statusView.backgroundColor = Constants.appColor
        }
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: eventDetail?.eventDescription ?? "", image: imageView.image ?? UIImage())
    }
}
