//
//  ViewStatusViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 7/19/23.
//

import UIKit
import SDWebImage
class ViewStatusViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.sd_setImage(with: URL(string: Route.baseUrl + (imageUrl ?? "")))
        let panGesture = UITapGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
