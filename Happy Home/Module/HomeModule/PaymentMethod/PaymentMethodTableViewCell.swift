//
//  PaymentMethodTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit



class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    var didTapButton: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pointsLabel.text = "50 \(LocalizationKeys.points.rawValue.localizeString())"
        methodLabel.text =  LocalizationKeys.cashOnDelivery.rawValue.localizeString()
        commentLabel.text =  LocalizationKeys.useTheWalletPoints.rawValue.localizeString()

    }
    
    var payment: PaymentMethod? {
        didSet{
            imgview.image = UIImage(named: payment?.icon ?? "")
            methodLabel.text = payment?.name
            commentLabel.text = payment?.description
            checkImageView.image = UIImage(named: payment?.navigateTo == true ? Helper.shared.isRTL() ? "ar-circle-forward-arrow" : "circle-forward-arrow" : "card-uncheck")
            pointsView.isHidden = payment?.point == -1 ? true :false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(isSelected: Bool) {
        checkImageView.image = UIImage(named: isSelected ? "card-checkmark" : "card-uncheck")
    }
    
    @IBAction func checkButtonAction(_ sender: Any) {
        didTapButton?()
    }
}

