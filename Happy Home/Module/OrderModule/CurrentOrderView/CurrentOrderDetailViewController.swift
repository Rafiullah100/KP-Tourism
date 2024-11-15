//
//  CurrentOrderDetailViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/6/24.
//

import UIKit

class CurrentOrderDetailViewController: UIViewController, ProductNavigationViewDelegate {
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBOutlet weak var deliveredImageView: UIImageView!
    @IBOutlet weak var shippedImageView: UIImageView!
    @IBOutlet weak var prepareImageView: UIImageView!
    @IBOutlet weak var acceptedImageView: UIImageView!
    @IBOutlet weak var deliveredLabel: UILabel!
    @IBOutlet weak var shippedLabel: UILabel!
    @IBOutlet weak var prepareLabel: UILabel!
    @IBOutlet weak var acceptedLabel: UILabel!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    @IBOutlet weak var cancelOrderButton: UIButton!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var orderIDValueLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var navigationView: OrderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.label.text = LocalizationKeys.viewOrder.rawValue.localizeString()
        orderIDLabel.text = LocalizationKeys.orderID.rawValue.localizeString()
        paymentMethodLabel.text = LocalizationKeys.paymentMethod.rawValue.localizeString()
        successLabel.text = LocalizationKeys.successfully.rawValue.localizeString()
        paymentStatusLabel.text = LocalizationKeys.paymentStatus.rawValue.localizeString()
        acceptedLabel.text = LocalizationKeys.accepted.rawValue.localizeString()
        prepareLabel.text = LocalizationKeys.preparing.rawValue.localizeString()
        shippedLabel.text = LocalizationKeys.shipped.rawValue.localizeString()
        deliveredLabel.text = LocalizationKeys.delivered.rawValue.localizeString()
        cancelOrderButton.setTitle(LocalizationKeys.requestOrderCancel.rawValue.localizeString(), for: .normal)

        navigationView.delegate = self
        navigationView.backIcon.image = UIImage(named: Helper.shared.isRTL() ? "ar-back-circle-arrow" : "back-circle-arrow")
    }
    
    @IBAction func cancelOrderButtonAction(_ sender: Any) {
        Switcher.gotoCancelOrder(delegate: self)
    }
    
}
