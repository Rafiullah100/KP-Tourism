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
    
    @IBOutlet weak var favoriteBtn: UIButton!
    var eventDetail: EventListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Events, \(eventDetail?.locationTitle ?? "")"
        titLabel.text = eventDetail?.title
        eventTypeLabel.text = eventDetail?.locationTitle
        descriptionLabel.text = eventDetail?.eventDescription?.stripOutHtml()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (eventDetail?.thumbnailImage ?? "")))
        openDateLabel.text = "\(eventDetail?.startDate ?? "") | \(eventDetail?.isExpired ?? "")"
        if eventDetail?.socialEventUsers?.count != 0 {
            interestGoingLabel.text = "\(eventDetail?.socialEventUsers?[0].userCount ?? 0) Interested"
        }
        if eventDetail?.isExpired == "Closed" {
            statusView.backgroundColor = .red
        }
        else{
            statusView.backgroundColor = Constants.appColor
        }
        favoriteBtn.setImage(eventDetail?.userLike == 0 ? UIImage(named: "white-heart") : UIImage(named: "favorite"), for: .normal)

        view.bringSubviewToFront(statusView)
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: eventDetail?.eventDescription ?? "", image: imageView.image ?? UIImage())
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        self.like(route: .likeApi, method: .post, parameters: ["section_id": eventDetail?.id ?? 0, "section": "social_event"], model: SuccessModel.self)
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                DispatchQueue.main.async {
                    self.favoriteBtn.setImage(successDetail?.message == "Liked" ? UIImage(named: "fav") : UIImage(named: "white-heart"), for: .normal)

                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
