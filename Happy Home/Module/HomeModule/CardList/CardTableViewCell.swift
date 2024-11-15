//
//  CardTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    var didTapButton: (() -> Void)?

    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expireLabel.text = "10/2 \(LocalizationKeys.expires.rawValue.localizeString())"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(isSelected: Bool) {
        checkMarkImageView.image = UIImage(named: isSelected ? "card-checkmark" : "card-uncheck")
    }
    
    @IBAction func checkmarkButtonAction(_ sender: Any) {
        didTapButton?()
    }
}
