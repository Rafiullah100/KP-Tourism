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
            tableView.register(UINib(nibName: "CommentReplyTableViewCell", bundle: nil), forCellReuseIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
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
    var limit = 5
    var currentPage = 1
    var totalCount = 1
    var allComments: [CommentsRows] = [CommentsRows]()
    var likeCount = 0
    var viewsCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.accomodationModelObject = accomodationDetail
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        commentTextView.isScrollEnabled = false
        commentTextView.inputAccessoryView = UIView()
        commentTextView.autocorrectionType = .no
        type = .backWithTitle
        viewControllerTitle = "\(accomodationDetail?.title ?? "") | Accomodation"
        detailView.isHidden = true
        favoriteBtn.isUserInteractionEnabled = Helper.shared.disableWhenNotLogin()

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
        favoriteBtn.setImage(accomodationDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
        likeCount = accomodationDetail?.likeCount ?? 0
        viewsCount = accomodationDetail?.viewsCounter ?? 0
        likeCountLabel.text = "\(likeCount) Liked"
        viewCounterLabel.text = "\(viewsCount) Views"
        viewCounter(parameters: ["section_id": accomodationDetail?.id ?? 0, "section": "book_stay"])
        reloadComment()
    }
    
    func viewCounter(parameters: [String: Any]) {
        URLSession.shared.request(route: .viewCounter, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let viewCount):
                if viewCount.success == true {
                    guard var modelObject = DataManager.shared.accomodationModelObject else {
                        return
                    }
                    modelObject.viewsCounter = self.viewsCount + 1
                    DataManager.shared.accomodationModelObject = modelObject
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constant = tableView.contentSize.height
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
        self.like(parameters: ["section_id": accomodationDetail?.id ?? 0, "section": "book_stay"])
    }
    
    func like(parameters: [String: Any]) {
        URLSession.shared.request(route: .likeApi, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let like):
                if like.success == true {
                    self.favoriteBtn.setImage(like.message == "Liked" ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
                    self.likeCount = like.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                    print(like.message ?? "", self.likeCount)
                    self.likeCountLabel.text = "\(self.likeCount) Liked"
                    self.changeObject()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func changeObject(){
        guard var modelObject = DataManager.shared.accomodationModelObject else {
            return
        }
        modelObject.likeCount = self.likeCount
        modelObject.userLike = modelObject.userLike == 1 ? 0 : 1
        DataManager.shared.accomodationModelObject = modelObject
    }
    
    @IBAction func directionBtnAction(_ sender: Any) {
        guard let originCoordinate = originCoordinate, let lat: Double = Double(accomodationDetail?.latitude ?? ""),let lon: Double = Double(accomodationDetail?.longitude ?? "") else {
            self.view.makeToast(Constants.noCoordinate)
            return  }
        getDirection(originCoordinate: originCoordinate, destinationCoordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
    }
    
    private func reloadComment(){
        fetchComment(parameters: ["section_id": accomodationDetail?.id ?? 0, "section": "book_stay", "page": currentPage, "limit": limit])
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
        doComment(parameters: ["section_id": accomodationDetail?.id ?? "", "section": "book_stay", "comment": text])
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
    
    func commentReply(parameters: [String: Any], row: IndexPath) {
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
            case .success(let result):
                self.totalCount = result.comments?.count ?? 1
                self.allComments.append(contentsOf: result.comments?.rows ?? [])
                self.tableView.reloadData()
//                Helper.shared.tableViewHeight(tableView: self.tableView, tbHeight: self.tableViewHeight)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
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
            commentTextView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text == "" {
            commentTextView.text = commentText
            commentTextView.textColor = UIColor.lightGray
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

extension AccomodationDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allComments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allComments[section].replies?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = allComments[indexPath.section]
        if indexPath.row == 0 {
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
                self.commentReply(parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "book_stay"], row: indexPath)
                self.allComments = []
            }
            
            cell.textViewCellDidChangeHeight = {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            return cell
        }
        else{
            let cell: CommentReplyTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentReplyTableViewCell.cellReuseIdentifier())  as! CommentReplyTableViewCell
            cell.commentReply = comment.replies?[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AccomodationDetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            print(allComments.count, totalCount)
            if allComments.count != totalCount{
                currentPage = currentPage + 1
                reloadComment()
            }
        }
    }
}
