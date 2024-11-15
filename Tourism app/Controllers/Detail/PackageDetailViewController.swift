//
//  PackageDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/30/22.
//

import UIKit
import SDWebImage
import SVProgressHUD
class PackageDetailCell: UITableViewCell{
    
    @IBOutlet weak var stayinLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expandableView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var activity: TourActivities? {
        didSet{
            titleLabel.text = "Day \(activity?.day ?? 0)"
            departureTimeLabel.text = activity?.departure_time
            departureDateLabel.text = activity?.departure_date
            stayinLabel.text = activity?.stay_in
            descriptionLabel.text = activity?.description?.stripOutHtml()
        }
    }
    
    var wishlistActivity: WishlistTourPackageActivity? {
        didSet{
            titleLabel.text = "Day \(wishlistActivity?.day ?? 0)"
            departureTimeLabel.text = wishlistActivity?.departureTime
            departureDateLabel.text = wishlistActivity?.departureDate
            stayinLabel.text = wishlistActivity?.stayIn
            descriptionLabel.text = wishlistActivity?.description?.stripOutHtml()
        }
    }
}




class PackageDetailViewController: BaseViewController {
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var packageNameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    var selectedRow: Int?
    var tourDetail: TourPackage?
    var detailType: DetailType?
    var wishlistTourPackage: WishlistTourPackage?

    @IBOutlet weak var commentTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var eventTypeLabel: UILabel!
    
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var districtNameLabel: UILabel!
    
    @IBOutlet weak var durationDateLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var statusBarView: UIView!
    
    @IBOutlet weak var viewCounterLabel: UILabel!
    var interestCount = 0
    
    var commentText = "Write a comment"
    var limit = 100
    var currentPage = 1
    var totalCount = 1
    var allComments: [CommentsRows] = [CommentsRows]()
    
    @IBOutlet weak var commenTableView: DynamicHeightTableView!{
        didSet{
            commenTableView.delegate = self
            commenTableView.dataSource = self
            commenTableView.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var commentTextView: UITextView!{
        didSet{
            commentTextView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 60.0
        
        commenTableView.rowHeight = UITableView.automaticDimension
        commenTableView.rowHeight = 60.0
        
        commentTextView.text = commentText
        commentTextView.textColor = UIColor.lightGray
        
        updateUI()
        reloadComment()
    }
    
    private func updateUI(){
        
        if detailType == .list {
            viewControllerTitle = "\(tourDetail?.title ?? "") | Tour Packages"

            imageView.sd_setImage(with: URL(string: Route.baseUrl + (tourDetail?.preview_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
            packageNameLabel.text = tourDetail?.title
            descriptionLabel.text = tourDetail?.description?.stripOutHtml()
            daysLabel.text = tourDetail?.duration_days
            
            eventTypeLabel.text = tourDetail?.family == true ? "EVENT TYPE: FAMILY" : "EVENT TYPE: ADULTS"
            amountLabel.text = tourDetail?.price == 0 ? "FREE" : "RS. \(tourDetail?.price ?? 0)"
            favoriteIcon.image = tourDetail?.userInterest == 1 ? UIImage(named: "interested-red") : UIImage(named: "interested")
            durationDateLabel.text = "\(tourDetail?.startDate ?? "") TO \(tourDetail?.endDate ?? "")"
            viewsLabel.text = "\(tourDetail?.views_counter ?? 0) VIEWS"
            counterLabel.text = "\(tourDetail?.number_of_people ?? 0) Seats"
            districtNameLabel.text = tourDetail?.to_districts?.title
            registrationLabel.text = "Last registration date \(tourDetail?.startDate ?? "")"
            interestCount = tourDetail?.usersInterestCount ?? 0
            likeLabel.text = "\(String(describing: interestCount)) Interested"
            viewCounterLabel.text = "\(tourDetail?.views_counter ?? 0) Views"
            viewCounter(route: .viewCounter, method: .post, parameters: ["section_id": tourDetail?.id ?? 0, "section": "tour_package"], model: SuccessModel.self)
        }
        else if detailType == .wishlist{
            viewControllerTitle = "\(wishlistTourPackage?.title ?? "") | Tour Packages"
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (wishlistTourPackage?.previewImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
            packageNameLabel.text = wishlistTourPackage?.title
            descriptionLabel.text = wishlistTourPackage?.description?.stripOutHtml()
            daysLabel.text = wishlistTourPackage?.durationDays
            eventTypeLabel.text = wishlistTourPackage?.family == true ? "EVENT TYPE: FAMILY" : "EVENT TYPE: ADULTS"
            amountLabel.text = wishlistTourPackage?.price == 0 ? "FREE" : "RS. \(wishlistTourPackage?.price ?? 0)"
            favoriteIcon.image = wishlistTourPackage?.userInterest == 1 ? UIImage(named: "interested-red") : UIImage(named: "interested")
            durationDateLabel.text = "\(wishlistTourPackage?.startDate ?? "") TO \(wishlistTourPackage?.endDate ?? "")"
            viewsLabel.text = "\(wishlistTourPackage?.viewsCounter ?? 0) VIEWS"
            counterLabel.text = "\(wishlistTourPackage?.numberOfPeople ?? 0) Seats"
            districtNameLabel.text = wishlistTourPackage?.toDistricts.title
            registrationLabel.text = "Last registration date \(wishlistTourPackage?.startDate ?? "")"
            interestCount = wishlistTourPackage?.usersInterestCount ?? 0
            likeLabel.text = "\(String(describing: interestCount)) Interested"
            viewCounterLabel.text = "\(wishlistTourPackage?.viewsCounter ?? 0) Views"
            viewCounter(route: .viewCounter, method: .post, parameters: ["section_id": tourDetail?.id ?? 0, "section": "tour_package"], model: SuccessModel.self)
        }
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
    }
    
    private func reload(){
        self.tableViewHeight.constant = CGFloat.greatestFiniteMagnitude
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        if detailType == .list{
            guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
            self.interest(route: .doInterest, method: .post, parameters: ["package_id": tourDetail?.id ?? 0], model: SuccessModel.self)
        }
        else if detailType == .wishlist{
            guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
            self.interest(route: .doInterest, method: .post, parameters: ["package_id": wishlistTourPackage?.id ?? 0], model: SuccessModel.self)
        }
        
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
    
    func interest<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let wish):
                let successDetail = wish as? SuccessModel
                self.favoriteIcon.image = successDetail?.message == "Interest Added" ? UIImage(named: "interested-red") : UIImage(named: "interested")
                self.interestCount = successDetail?.message == "Interest Added" ? self.interestCount + 1 : self.interestCount - 1
                self.likeLabel.text = "\(self.interestCount) Interested"
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        if detailType == .list{
            self.share(text: tourDetail?.description ?? "", image: imageView.image ?? UIImage())
        }
        else if detailType == .wishlist{
            self.share(text: wishlistTourPackage?.description ?? "", image: imageView.image ?? UIImage())
        }
    }
    
    private func reloadComment(){
        if detailType == .list{
            fetchComment(route: .fetchComment, method: .post, parameters: ["section_id": tourDetail?.id ?? 0, "section": "tour_package", "page": currentPage, "limit": limit], model: CommentsModel.self)
        }
        else{
            fetchComment(route: .fetchComment, method: .post, parameters: ["section_id": wishlistTourPackage?.id ?? 0, "section": "tour_package", "page": currentPage, "limit": limit], model: CommentsModel.self)
        }
    }
    
    @IBAction func loginToComment(_ sender: Any) {
        if detailType == .list{
            guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
            doComment(route: .doComment, method: .post, parameters: ["section_id": tourDetail?.id ?? "", "section": "tour_package", "comment": text], model: SuccessModel.self)
        }
        else{
            guard let text = commentTextView.text, !text.isEmpty, text != commentText else { return }
            doComment(route: .doComment, method: .post, parameters: ["section_id": wishlistTourPackage?.id ?? "", "section": "tour_package", "comment": text], model: SuccessModel.self)
        }
       
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
                    self.commenTableView.scrollToRow(at: row, at: .none, animated: false)
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
                self.totalCount = (comments as? CommentsModel)?.comments?.count ?? 1
                self.allComments.append(contentsOf: (comments as? CommentsModel)?.comments?.rows ?? [])
                print(self.allComments.count)
                Helper.shared.tableViewHeight(tableView: self.commenTableView, tbHeight: self.commentTableViewHeight)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension PackageDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            if detailType == .list{
                return tourDetail?.activities?.count ?? 0
            } else if detailType == .wishlist{
                return wishlistTourPackage?.activities.count ?? 0
            }
            return 0
        }
        else{
            print(allComments.count)
            return allComments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView{
            let cell: PackageDetailCell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier") as! PackageDetailCell
            
            if detailType == .list{
                cell.activity = tourDetail?.activities?[indexPath.row]
            }
            else if detailType == .wishlist{
                cell.wishlistActivity = wishlistTourPackage?.activities[indexPath.row]
            }
            if indexPath.row == selectedRow{
                if cell.expandableView.isHidden == false{
                    cell.expandableView.isHidden = true
                    cell.imgView.image = #imageLiteral(resourceName: "collapse")
                }
                else{
                    cell.expandableView.isHidden = false
                    cell.imgView.image = #imageLiteral(resourceName: "expand")
                }
            }
            else{
                cell.expandableView.isHidden = true
                cell.imgView.image = #imageLiteral(resourceName: "collapse")
            }
            return cell
        }
        else{
            let cell: CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellReuseIdentifier()) as! CommentsTableViewCell
            cell.comment = allComments[indexPath.row]
            cell.commentReplyBlock = {
                cell.bottomView.isHidden = !cell.bottomView.isHidden
                Helper.shared.tableViewHeight(tableView: self.commenTableView, tbHeight: self.commentTableViewHeight)
            }
            cell.actionBlock = { text in
                cell.textView.text = ""
                self.commentReply(route: .commentReply, method: .post, parameters: ["reply": text, "comment_id": self.allComments[indexPath.row].id ?? "", "section": "tour_package"], model: SuccessModel.self, row: indexPath)
                self.allComments = []
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            selectedRow = indexPath.row
            reload()
        }
        
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        tableViewHeight.constant = tableView.contentSize.height
//    }
}


extension PackageDetailViewController: UITextViewDelegate{
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
