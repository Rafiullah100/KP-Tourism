//
//  OrderTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/6/24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    var didTapButton: (() -> Void)?

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureStatusView(type: OrderType){
        switch type {
        case .completed:
            statusLabel.text = "Pending"
            statusView.backgroundColor = CustomColor.pendingOrderBackgroundColor.color
            statusLabel.textColor = CustomColor.pendingOrderTextColor.color
        case .current:
            statusLabel.text = "Out for Delivery"
            statusView.backgroundColor = CustomColor.deliveryOrderBackgroundColor.color
            statusLabel.textColor = CustomColor.deliveryOrderTextColor.color
        case .cancelled:
            statusLabel.text = "Canceled"
            statusView.backgroundColor = CustomColor.canceledOrderBackgroundColor.color
            statusLabel.textColor = CustomColor.canceledOrderTextColor.color
        }
    }
    
    @IBAction func viewOrderButtonAction(_ sender: Any) {
        didTapButton?()
    }
}
