//
//  BlogDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/1/22.
//

import UIKit

class BlogDetailViewController: BaseViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        type = .backWithTitle
        viewControllerTitle = "7 Things to do in Peshawar"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textViewHeight.constant = textView.contentSize.height
    }
}
