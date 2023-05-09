//
//  TourPdfViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit
import MessageUI
class TourPdfViewController: BaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        contentView.isHidden = false
    }
    
    @IBAction func pdfBtnAction(_ sender: Any) {
//        Switcher.gotoPdfDownloadVC(delegate: self)
        let area = UserDefaults.standard.area
        let experience = UserDefaults.standard.experience
        let destination = UserDefaults.standard.destination
        let information = UserDefaults.standard.information
        let accomodation = UserDefaults.standard.accomodation
        fetch(route: .visitpdf, method: .post, parameters: ["name": "", "email": "", "informations": information ?? "", "visits": area ?? "", "destination": destination ?? "", "experience": experience ?? "", "type": "pdf"], model: PDFModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let pdf):
                print("will d")
            case .failure(let error):
                print("ekrmf")
            }
        }
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
        let items = "\(UserDefaults.standard.area ?? "") \n \(UserDefaults.standard.experience ?? "") \n  \(UserDefaults.standard.destination ?? "") \n  \(UserDefaults.standard.information ?? "") \n \(UserDefaults.standard.accomodation ?? "")"
        print(items)
        let ac = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TourPdfViewController: MFMailComposeViewControllerDelegate {
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        if let _ = error {
//            controller.dismiss(animated: true, completion: nil)
//            return
//        }
//        switch result {
//        case .cancelled:
//            break
//        case .failed:
//            break
//        case .saved:
//            break
//        case .sent:
//            break
//        }
//        controller.dismiss(animated: true, completion: nil)
//    }
}

