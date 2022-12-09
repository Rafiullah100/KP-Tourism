//
//  ProductDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "Umbrella | Local Products"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textViewHeight.constant = textView.contentSize.height
//        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: textViewHeight.constant + bottomView.frame.height + 50)
    }
}
