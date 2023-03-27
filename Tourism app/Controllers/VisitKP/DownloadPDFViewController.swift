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
}

class DownloadPDFViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pdfDownload(_ sender: Any) {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, tableView.bounds, nil)
        UIGraphicsBeginPDFPage()
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
       tableView.layer.render(in: pdfContext)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
