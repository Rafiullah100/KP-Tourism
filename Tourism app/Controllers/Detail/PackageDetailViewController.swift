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
}


class PackageDetailViewController: BaseViewController {
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var packageNameLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    var selectedRow: Int?
    var tourDetail: TourPackage?
    
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
    
    var interestCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "\(tourDetail?.title ?? "") | Tour Packages"

        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 60.0
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

//        descriptionLabel.text = "Up to 23 million people could be affected by the massive earthquake that has killed thousands in Turkey and Syria, the WHO warned on Tuesday, promising long-term assistance."
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
        guard UserDefaults.standard.userID != 0, UserDefaults.standard.userID != nil else { return }
        self.interest(route: .doInterest, method: .post, parameters: ["package_id": tourDetail?.id ?? 0], model: SuccessModel.self)
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
        self.share(text: tourDetail?.description ?? "", image: imageView.image ?? UIImage())
    }
    
}

extension PackageDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourDetail?.activities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PackageDetailCell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier") as! PackageDetailCell
        cell.activity = tourDetail?.activities?[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        reload()
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        tableViewHeight.constant = tableView.contentSize.height
//    }
}


