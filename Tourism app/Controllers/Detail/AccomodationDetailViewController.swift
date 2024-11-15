//
//  AccomodationDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit
import SDWebImage
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import MapboxMaps
import CoreLocation
import SVProgressHUD
class AccomodationDetailViewController: BaseViewController {
  
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var viewCounterLabel: UILabel!
    
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
    
    var accomodationDetail: Accomodation?
    var destinationCoordinate: CLLocationCoordinate2D?
    var originCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var commentText = "Write a comment"
    var limit = 100
    var currentPage = 1
    var totalCount = 1
    var allComments: [CommentsRows] = [CommentsRows]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        
        type = .backWithTitle
        viewControllerTitle = "\(accomodationDetail?.title ?? "") | Accomodation"
        detailView.isHidden = true
        
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (accomodationDetail?.previewImage ?? "")))
        nameLabel.text = "\(accomodationDetail?.title ?? "")"
        locationLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
        textView.text = "\(accomodationDetail?.description ?? "")".stripOutHtml()
        familyLabel.text = accomodationDetail?.family == true ? "Family" : "Adult"
        addressLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
//        ratingLabel.text = "\(accomodationDetail?.locationTitle ?? "")"
        priceLabel.text = "RS. \(accomodationDetail?.priceFrom ?? 0) PER NIGHT"
        bedLabel.text = "\(accomodationDetail?.noRoom ?? 0) Rooms"
        parkingLabel.text = accomodationDetail?.parking == true ? "Avialable" : "No Parking"
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        viewCounterLabel.text = "\(accomodationDetail?.viewsCounter ?? 0) Views"
        viewCounter(route: .viewCounter, method: .post, parameters: ["section_id": accomodationDetail?.id ?? 0, "section": "book_stay"], model: SuccessModel.self)
        reloadComment()
    }
    
    func viewCounter<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let viewCount):
                print(viewCount)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
        DispatchQueue.global().async {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
        
    }
    
    @IBAction func showDetailBtn(_ sender: Any) {
        if detailView.isHidden == true {
            detailView.isHidden = false
            dropDownImageView.image = UIImage(named: "collapse")
        }
        else{
            detailView.isHidden = true
            dropDownImageView.image = UIImage(named: "expand")
        }
    }
    @IBAction func likeBtnAction(_ sender: Any) {
    }
    
    @IBAction func directionBtnAction(_ sender: Any) {
        guard let originCoordinate = originCoordinate, let latitude: Double = Double(accomodationDetail?.latitude ?? ""), let longitude: Double = Double(accomodationDetail?.longitude ?? "") else { return  }
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), name: "")
        
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
        fetchComment(route: .fetchComment, method: .post, parameters: ["section_id": accomodationDetail?.id ?? 0, "section": "book_stay", "page": currentPage, "limit": limit], model: CommentsModel.self)
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        doComment(route: .doComment, method: .post, parameters: ["section_id": accomodationDetail?.id ?? "", "section": "book_stay", "comment": text], model: SuccessModel.self)
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

extension AccomodationDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        originCoordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}


extension AccomodationDetailViewController: UITextViewDelegate{
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

extension AccomodationDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellReuseIdentifier()) as! CommentsTableViewCell
        cell.comment = allComments[indexPath.row]
        cell.commentReplyBlock = {
            cell.bottomView.isHidden = !cell.bottomView.isHidden
            Helper.shared.tableViewHeight(tableView: self.tableView, tbHeight: self.tableViewHeight)
        }
        cell.actionBlock = { text in
            cell.textView.text = ""
            self.commentReply(route: .commentReply, method: .post, parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "book_stay"], model: SuccessModel.self, row: indexPath)
            self.allComments = []
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
