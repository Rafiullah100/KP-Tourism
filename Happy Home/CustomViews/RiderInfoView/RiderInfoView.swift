//
//  RiderInfoView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/5/24.
//

import UIKit

class RiderInfoView: UIView {
        
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var whatsappLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "RiderInfoView", bundle: nil)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoLabel.text = LocalizationKeys.riderInfo.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.riderName.rawValue.localizeString()
        phoneLabel.text = LocalizationKeys.phoneNo.rawValue.localizeString()
        whatsappLabel.text = LocalizationKeys.whatsapp.rawValue.localizeString()
        nationalityLabel.text = LocalizationKeys.nationality.rawValue.localizeString()
    }
}

