//
//  OrderTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/6/24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    var didTapButton: (() -> Void)?

    @IBOutlet weak var riyalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var viewOrderButton: UIButton!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        riyalLabel.text = LocalizationKeys.riyal.rawValue.localizeString()
        totalLabel.text = LocalizationKeys.totalamount.rawValue.localizeString()
        viewOrderButton.setTitle(LocalizationKeys.viewOrderDetails.rawValue.localizeString(), for: .normal)
        riyalLabel.text = LocalizationKeys.riyal.rawValue.localizeString()
        orderLabel.text = LocalizationKeys.order.rawValue.localizeString()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureStatusView(type: OrderType){
        switch type {
        case .completed:
            statusLabel.text = LocalizationKeys.pending.rawValue.localizeString()
            statusView.backgroundColor = CustomColor.pendingOrderBackgroundColor.color
            statusLabel.textColor = CustomColor.pendingOrderTextColor.color
        case .current:
            statusLabel.text = LocalizationKeys.outForDelivery.rawValue.localizeString()
            statusView.backgroundColor = CustomColor.deliveryOrderBackgroundColor.color
            statusLabel.textColor = CustomColor.deliveryOrderTextColor.color
        case .cancelled:
            statusLabel.text = LocalizationKeys.canceled.rawValue.localizeString()
            statusView.backgroundColor = CustomColor.canceledOrderBackgroundColor.color
            statusLabel.textColor = CustomColor.canceledOrderTextColor.color
        }
    }
    
    @IBAction func viewOrderButtonAction(_ sender: Any) {
        didTapButton?()
    }
}
