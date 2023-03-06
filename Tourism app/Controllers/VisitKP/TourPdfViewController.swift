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
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, contentView.bounds, nil)
        UIGraphicsBeginPDFPage()
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
       contentView.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
       let activityViewController = UIActivityViewController(activityItems: [pdfData] , applicationActivities: nil)
       activityViewController.popoverPresentationController?.sourceView = self.view
       self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
//        guard MFMailComposeViewController.canSendMail() else {
//            return
//        }
//        let composer = MFMailComposeViewController()
//        composer.mailComposeDelegate = self
//        composer.setToRecipients(["rafiullah@codeforpakistan.org"])
//        composer.setSubject("Your Tour Plan")
//        present(composer, animated: true)
        
        let items = "\(UserDefaults.standard.area ?? "") \n \(UserDefaults.standard.experience ?? "") \n  \(UserDefaults.standard.destination ?? "") \n  \(UserDefaults.standard.information ?? "") \n \(UserDefaults.standard.accomodation ?? "")"
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

