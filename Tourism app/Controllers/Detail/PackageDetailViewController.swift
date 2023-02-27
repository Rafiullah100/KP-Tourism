//
//  PackageDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/30/22.
//

import UIKit
import SDWebImage

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = tourDetail?.title
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 60.0
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (tourDetail?.thumbnail_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        packageNameLabel.text = tourDetail?.title
        descriptionLabel.text = tourDetail?.description?.stripOutHtml()
        daysLabel.text = tourDetail?.duration_days
        
        eventTypeLabel.text = tourDetail?.family == true ? "EVENT TYPE: FAMILY" : "EVENT TYPE: ADULTS"
        amountLabel.text = tourDetail?.price == 0 ? "FREE" : "RS. \(tourDetail?.price ?? 0)"
        favoriteIcon.image = tourDetail?.userLike == 1 ? UIImage(named: "fav") : UIImage(named: "white-heart")
        likeLabel.text = "0 Liked"
        durationDateLabel.text = "\(tourDetail?.startDate ?? "") TO \(tourDetail?.endDate ?? "")"
        viewsLabel.text = "\(tourDetail?.views_counter ?? 0) VIEWS"
        counterLabel.text = "\(tourDetail?.number_of_people ?? 0)"
        districtNameLabel.text = tourDetail?.to_districts?.title
        registrationLabel.text = "Last registration date \(tourDetail?.startDate ?? "")"
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
        self.like(route: .likeApi, method: .post, parameters: ["section_id": tourDetail?.id ?? 0, "section": "tour_package"], model: SuccessModel.self)
    }
    
    func like<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let like):
                let successDetail = like as? SuccessModel
                DispatchQueue.main.async {
                    self.favoriteIcon.image = successDetail?.message == "Liked" ? UIImage(named: "fav") : UIImage(named: "white-heart")
                }
            case .failure(let error):
                print("error \(error)")
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


