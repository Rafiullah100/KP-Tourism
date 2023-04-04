//
//  DownloadPDFViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/23/23.
//

import UIKit

class DownloadpdfTableViewCell: UITableViewCell {
    @IBOutlet weak var imgBGView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 10
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        imgBGView.clipsToBounds = true
        imgBGView.layer.cornerRadius = 10
        imgBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bottomView.viewShadow()
    }
    
//    var pdf: VisitPdf? {
//        didSet{
//
//        }
//    }
}

class DownloadPDFViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pdfArray: [VisitPdf]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func pdfDownload(_ sender: Any) {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, view.bounds, nil)
        UIGraphicsBeginPDFPage()
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
       view.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
       let activityViewController = UIActivityViewController(activityItems: [pdfData] , applicationActivities: nil)
       activityViewController.popoverPresentationController?.sourceView = self.view
       self.present(activityViewController, animated: true, completion: nil)
    }
}

extension DownloadPDFViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DownloadpdfTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! DownloadpdfTableViewCell
        if indexPath.row == 0 {
            cell.imgBGView.isHidden = false
            if let data = UserDefaults.standard.data(forKey: "area"),
                let area = try? JSONDecoder().decode(VisitArea.self, from: data) {
                cell.nameLabel.text = area.title
                cell.imgView.image = UIImage(named: area.background)
            }
        }
        else if indexPath.row == 1 {
            cell.imgBGView.isHidden = false
            if let data = UserDefaults.standard.data(forKey: "experience"),
                let experience = try? JSONDecoder().decode(DistrictCategorory.self, from: data) {
                cell.nameLabel.text = experience.title
                cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (experience.icon)))
            }
        }
        else if indexPath.row == 2 {
            cell.imgBGView.isHidden = false
            if let data = UserDefaults.standard.data(forKey: "destination"),
                let destination = try? JSONDecoder().decode(DistrictsListRow.self, from: data) {
                cell.nameLabel.text = destination.title
                cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (destination.preview_image ?? "")))
            }
        }
        else if indexPath.row == 4 {
            cell.imgBGView.isHidden = true
            let information = UserDefaults.standard.information
            cell.nameLabel.text = information
        }
        else if indexPath.row == 3 {
            cell.imgBGView.isHidden = false
            if let data = UserDefaults.standard.data(forKey: "accomodation"),
                let accomodation = try? JSONDecoder().decode(Accomodation.self, from: data) {
                cell.nameLabel.text = accomodation.title
                cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (accomodation.previewImage)))
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
