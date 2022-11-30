//
//  PackageDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 11/30/22.
//

import UIKit

class PackageDetailViewController: BaseViewController {
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        viewControllerTitle = "Naran Package"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textViewHeight.constant = textView.contentSize.height
//        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: textView.contentSize.height + tableView.contentSize.height + 100)
    }
}

extension PackageDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier")
        cell?.textLabel?.text = "Row \(indexPath.row)"
        return cell ?? UITableViewCell()
    }
    
    
}


