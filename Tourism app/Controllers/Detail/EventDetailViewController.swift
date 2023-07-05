//
//  EventDetailViewController.swift
//  Tourism app
//
//  Created by Rafi on 08/11/2022.
//

import UIKit
import SDWebImage
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import MapboxMaps
import SVProgressHUD
class EventDetailViewController: BaseViewController {

    @IBOutlet weak var olderCommentView: UIStackView!
    @IBOutlet weak var olderCommentsLabel: UILabel!
    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var interestGoingLabel: UILabel!
    
    @IBOutlet weak var favoriteBtn: UIButton!
   
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: DynamicHeightTableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var commentTextView: UITextView!{
        didSet{
            commentTextView.delegate = self
        }
    }
    
    var eventDetail: EventListModel?
    var wishlistEventDetail: WishlistSocialEvent?
    var detailType: DetailType?

    internal var mapView: MapView!
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var interestCount = 0
    var commentText = "Write a comment"
    var limit = 1000
    var currentPage = 1
    var totalCount = 1
    var allComments: [CommentsRows] = [CommentsRows]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        DataManager.shared.eventModelObject = eventDetail
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        commentTextView.isScrollEnabled = false
        commentTextView.inputAccessoryView = UIView()
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        view.bringSubviewToFront(statusView)
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        type = .backWithTitle
        viewControllerTitle = ""
        favoriteBtn.isUserInteractionEnabled = Helper.shared.disableWhenNotLogin()
        if detailType == .list {
            viewControllerTitle = "\(eventDetail?.title ?? "") | Events"
            titLabel.text = eventDetail?.title
            eventTypeLabel.text = eventDetail?.locationTitle
            descriptionLabel.text = eventDetail?.eventDescription?.stripOutHtml()
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (eventDetail?.previewImage ?? "")))
            openDateLabel.text = "\(eventDetail?.startDate ?? "") | \(eventDetail?.isExpired ?? "")"
            if eventDetail?.isExpired == "Closed" {
                statusView.backgroundColor = .red
            }else{
                statusView.backgroundColor = Constants.appColor
            }
            interestCount = eventDetail?.usersInterestCount ?? 0
            interestGoingLabel.text = "\(String(describing: interestCount)) Interested"
            favoriteBtn.setImage(eventDetail?.userInterest == 1 ? UIImage(named: "interested-red") : UIImage(named: "interested"), for: .normal)
        }
        else{
            viewControllerTitle = "\(wishlistEventDetail?.title ?? "") | Events"
            titLabel.text = wishlistEventDetail?.title
            eventTypeLabel.text = wishlistEventDetail?.locationTitle
            descriptionLabel.text = wishlistEventDetail?.description?.stripOutHtml()
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (wishlistEventDetail?.previewImage ?? "")))
            openDateLabel.text = "\(wishlistEventDetail?.startDate ?? "") | \(wishlistEventDetail?.isExpired ?? "")"
            if wishlistEventDetail?.isExpired == "Closed" {
                statusView.backgroundColor = .red
            }else{
                statusView.backgroundColor = Constants.appColor
            }
            interestCount = wishlistEventDetail?.usersInterestCount ?? 0
            interestGoingLabel.text = "\(String(describing: interestCount)) Interested"
            favoriteBtn.setImage(wishlistEventDetail?.userInterest == 1 ? UIImage(named: "interested-red") : UIImage(named: "interested"), for: .normal)
        }
        reloadComment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
        DispatchQueue.global().async {
            let locationManager = Helper.shared.locationPermission()
            locationManager.delegate = self
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constant = tableView.contentSize.height
    }
    
    @IBAction func directionBtnAction(_ sender: Any) {
        guard let originCoordinate = originCoordinate, let lat: Double = Double(eventDetail?.latitude ?? ""),let lon: Double = Double(eventDetail?.longitude ?? "") else {
            self.view.makeToast(Constants.noCoordinate)
            return  }
        getDirection(originCoordinate: originCoordinate, destinationCoordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
    }
    
    private func reloadComment(){
        let eventID = detailType == .list ? eventDetail?.id : wishlistEventDetail?.id
        fetchComment(parameters: ["section_id": eventID ?? 0, "section": "social_event", "page": currentPage, "limit": limit])
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        doComment(parameters: ["section_id": eventDetail?.id ?? "", "section": "social_event", "comment": text])
    }
    
    func doComment(parameters: [String: Any]) {
        URLSession.shared.request(route: .doComment, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let result):
                if result.success == true{
                    self.commentTextView.text = ""
                    self.allComments = []
                    self.reloadComment()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        let description = detailType == .list ? eventDetail?.eventDescription : eventDetail?.eventDescription
        let title = detailType == .list ? eventDetail?.title: eventDetail?.title
        self.share(title: title ?? "", text: description ?? "", image: imageView.image ?? UIImage())
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        let eventID = detailType == .list ? eventDetail?.id : wishlistEventDetail?.id
        self.interest(parameters: ["event_id": eventID ?? 0])
    }
    
    func interest(parameters: [String: Any]) {
        URLSession.shared.request(route: .doEventInterest, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let like):
                self.favoriteBtn.setImage(UIImage(named: like.message == "Interest Added" ? "interested-red" : "interested"), for: .normal)
                self.interestCount = like.message == "Interest Added" ? self.interestCount + 1 : self.interestCount - 1
                self.changeObject()
                self.interestGoingLabel.text = "\(self.interestCount) Interested"
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func changeObject(){
        guard var modelObject = DataManager.shared.eventModelObject else {
            return
        }
        modelObject.usersInterestCount = self.interestCount
        modelObject.userInterest = modelObject.userInterest == 1 ? 0 : 1
        DataManager.shared.eventModelObject = modelObject
    }
    
    func commentReply(parameters: [String: Any]? = nil, row: IndexPath) {
        URLSession.shared.request(route: .commentReply, method: .post, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let result):
                if result.success == true{
                    self.reloadComment()
                    self.tableView.scrollToRow(at: row, at: .none, animated: false)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func fetchComment(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchComment, method: .post, showLoader: false, parameters: parameters, model: CommentsModel.self) { result in
            switch result {
            case .success(let comments):
                self.totalCount = comments.comments?.count ?? 1
                self.allComments.append(contentsOf: comments.comments?.rows ?? [])
                self.tableView.reloadData()
                self.olderCommentView.isHidden = self.allComments.count == 0 ? true : false
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}

extension EventDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}

extension EventDetailViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text == "" {
            commentTextView.text = commentText
            commentTextView.textColor = UIColor.label
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == commentTextView{
            let fixedWidth = textView.frame.size.width
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            commentTextViewHeight.constant = newSize.height
            view.layoutIfNeeded()
        }
    }
}

extension EventDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellReuseIdentifier()) as! CommentsTableViewCell
        cell.comment = allComments[indexPath.row]
        cell.commentReplyBlock = {
            tableView.performBatchUpdates {
                UIView.animate(withDuration: 0.3) {
                    cell.bottomView.isHidden.toggle()
                }
            }
        }
        cell.actionBlock = { text in
            cell.textView.text = ""
            self.commentReply(parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "social_event"], row: indexPath)
            self.allComments = []
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
