//
//  OrderDetailView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/5/24.
//

import UIKit


class OrderDetailView: UIView {
        
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "OrderDetailView", bundle: nil)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailLabel.text = LocalizationKeys.orderDetails.rawValue.localizeString()
        priceLabel.text = LocalizationKeys.orderPrice.rawValue.localizeString()
        orderDate.text = LocalizationKeys.orderDate.rawValue.localizeString()
        timeLabel.text = LocalizationKeys.orderTime.rawValue.localizeString()
        deliveryDateLabel.text = LocalizationKeys.deliveryDate.rawValue.localizeString()
        locationLabel.text = LocalizationKeys.location.rawValue.localizeString()

    }
}

