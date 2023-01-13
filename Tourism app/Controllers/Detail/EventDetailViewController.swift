//
//  EventDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit
import SDWebImage
class EventDetailViewController: BaseViewController {

    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var eventDetail: EventListModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Events"
        titLabel.text = eventDetail?.locationTitle
        eventTypeLabel.text = eventDetail?.title
        descriptionLabel.text = eventDetail?.eventDescription
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (eventDetail?.thumbnailImage ?? "")))
        openDate()
    }
    
    func openDate() {
        let startDate = eventDetail?.startDate ?? ""
        print(startDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: startDate)
        dateFormatter.dateFormat = "d MMM"
        guard let date = date else { return  }
        let dateStr = dateFormatter.string(from: date).capitalized
        openDateLabel.text = "\(dateStr) | OPEN"
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: eventDetail?.eventDescription ?? "", image: imageView.image ?? UIImage())
    }
}
