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
    internal var mapView: MapView!
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var interestCount = 0
    var commentText = "Write a comment"
    var limit = 100
    var currentPage = 1
    var totalCount = 1
    var allComments: [CommentsRows] = [CommentsRows]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        type = .backWithTitle
        viewControllerTitle = ""
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
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        view.bringSubviewToFront(statusView)
        reloadComment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
        DispatchQueue.global().async {
            let locationManager = Helper.shared.locationPermission(self: self)
            locationManager.delegate = self
        }
    }
    
    @IBAction func directionBtnAction(_ sender: Any) {
        guard let originCoordinate = originCoordinate, let lat: Double = Double(eventDetail?.latitude ?? ""),let lon: Double = Double(eventDetail?.longitude ?? "") else { return  }
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), name: "")
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        SVProgressHUD.show(withStatus: "Please wait...")
        Directions(credentials: Credentials(accessToken: Constants.mapboxPublicKey)).calculate(routeOptions) { [weak self] (session, result) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let self = self else { return }
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    private func reloadComment(){
        fetchComment(route: .fetchComment, method: .post, parameters: ["section_id": eventDetail?.id ?? 0, "section": "social_event", "page": currentPage, "limit": limit], model: CommentsModel.self)
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        doComment(route: .doComment, method: .post, parameters: ["section_id": eventDetail?.id ?? "", "section": "social_event", "comment": text], model: SuccessModel.self)
    }
    
    func doComment<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let result):
                if (result as? SuccessModel)?.success == true{
                    self.commentTextView.text = ""
                    self.allComments = []
                    self.reloadComment()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        self.share(text: eventDetail?.eventDescription ?? "", image: imageView.image ?? UIImage())
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        self.interest(route: .doEventInterest, method: .post, parameters: ["event_id": eventDetail?.id ?? 0], model: SuccessModel.self)
    }
    
    func interest<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                self.favoriteBtn.setImage(UIImage(named: successDetail?.message == "Interest Added" ? "interested-red" : "interested"), for: .normal)
                self.interestCount = successDetail?.message == "Interest Added" ? self.interestCount + 1 : self.interestCount - 1
                self.interestGoingLabel.text = "\(self.interestCount) Interested"
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func commentReply<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, row: IndexPath) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let result):
                if (result as? SuccessModel)?.success == true{
                    self.reloadComment()
                    self.tableView.scrollToRow(at: row, at: .none, animated: false)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func fetchComment<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let comments):
                print((comments as? CommentsModel)?.comments?.rows ?? [])
                self.totalCount = (comments as? CommentsModel)?.comments?.count ?? 1
                self.allComments.append(contentsOf: (comments as? CommentsModel)?.comments?.rows ?? [])
                Helper.shared.tableViewHeight(tableView: self.tableView, tbHeight: self.tableViewHeight)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
            commentTextView.textColor = UIColor.lightGray
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
            cell.bottomView.isHidden = !cell.bottomView.isHidden
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        cell.actionBlock = { text in
            cell.textView.text = ""
            self.commentReply(route: .commentReply, method: .post, parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "social_event"], model: SuccessModel.self, row: indexPath)
            self.allComments = []
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
