//
//  GroupTourViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 10/30/24.
//

import UIKit

class GroupTourViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.textColor = .lightGray
        textView.text = "Enter Details here.."
    }

}

extension GroupTourViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .lightGray {
                textView.text = ""
                textView.textColor = .black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Enter Details here.."
                textView.textColor = .lightGray
            }
        }
}
