//
//  AccomodationDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/8/22.
//

import UIKit

class AccomodationDetailViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .backWithTitle
        viewControllerTitle = "Accomodations"
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        textViewHeight.constant = textView.contentSize.height
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: textView.contentSize.height + 50)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
