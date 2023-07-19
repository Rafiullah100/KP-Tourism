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
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let screenHeight = UIScreen.main.bounds.height
        switch gesture.state {
        case .ended:
            let dismissThreshold: CGFloat = screenHeight * 0.1
            if translation.y > dismissThreshold  {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
            
        default:
            break
        }
    }
}
