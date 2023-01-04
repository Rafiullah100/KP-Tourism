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
}


class PackageDetailViewController: BaseViewController {
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var packageNameLabel: UILabel!
    
    var selectedRow: Int?
    var tourDetail: TourPackage?
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = tourDetail?.title
//        tableView.rowHeight = UITableView.automaticDimension
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (tourDetail?.thumbnail_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        packageNameLabel.text = tourDetail?.title
        descriptionLabel.text = tourDetail?.description
        
    }
}

extension PackageDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourDetail?.activities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PackageDetailCell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier") as! PackageDetailCell
//        cell.subTitleLabel.isHidden = true
        cell.titleLabel.text = "Day \(tourDetail?.activities?[indexPath.row].day ?? 0)"
        cell.departureTimeLabel.text = tourDetail?.activities?[indexPath.row].departure_time
        cell.departureDateLabel.text = tourDetail?.activities?[indexPath.row].departure_date
        cell.stayinLabel.text = tourDetail?.activities?[indexPath.row].stay_in
        cell.descriptionLabel.text = tourDetail?.activities?[indexPath.row].description
        if indexPath.row == selectedRow{
            cell.expandableView.isHidden = false
            cell.imgView.image = #imageLiteral(resourceName: "expand")
        }
        else{
            cell.expandableView.isHidden = true
            cell.imgView.image = #imageLiteral(resourceName: "collapse")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.reloadData()
        let cell: PackageDetailCell = tableView.cellForRow(at: indexPath) as! PackageDetailCell
        tableViewHeight.constant = tableView.contentSize.height + cell.descriptionLabel.frame.height
//        cell.subTitleLabel.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewHeight.constant = tableView.contentSize.height
    }
}


