//
//  PaymentMethodTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit



class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var checkImageView: UIImageView!
    
    var didTapButton: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

