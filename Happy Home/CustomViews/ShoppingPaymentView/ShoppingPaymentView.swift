//
//  ShoppingPaymentView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit

protocol ShoppingDelegate {
    func shoppingViewButtonAction()
}


class ShoppingPaymentView: UIView {
    var delegate: ShoppingDelegate?
    @IBOutlet weak var attentionLabel: UILabel!
    
    @IBOutlet weak var subTotalValueLabel: UILabel!
    @IBOutlet weak var riyalLabel: UILabel!
    @IBOutlet weak var taxValueLabel: UILabel!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var chargesPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var chargesLabel: UILabel!
    @IBOutlet weak var totalItemLabel: UILabel!
    @IBOutlet weak var attentionValueLabel: UILabel!
    @IBOutlet weak var shoppingButton: UIButton!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vatLabel.text = "\(LocalizationKeys.vat.rawValue.localizeString()) 12314256632255"
        totalPriceLabel.text = "\(LocalizationKeys.riyal.rawValue.localizeString()) 18"
        subTotalValueLabel.text = "21.3"
        subtotalLabel.text = LocalizationKeys.subTotal.rawValue.localizeString()
        taxLabel.text = LocalizationKeys.tax.rawValue.localizeString()
        discountLabel.text = LocalizationKeys.discount.rawValue.localizeString()
        discountValueLabel.text = "\(LocalizationKeys.riyal.rawValue.localizeString()) 0"
        chargesLabel.text = LocalizationKeys.deliveryCharges.rawValue.localizeString()
        chargesPriceLabel.text = "\(LocalizationKeys.riyal.rawValue.localizeString()) 0"
        riyalLabel.text = LocalizationKeys.riyal.rawValue.localizeString()
        totalItemLabel.text = "\(LocalizationKeys.attention.rawValue.localizeString()) (4\(LocalizationKeys.items.rawValue.localizeString()))"
        attentionValueLabel.text = LocalizationKeys.youAreNotAllowedToCancelThisOrder.rawValue.localizeString()
        attentionLabel.text = LocalizationKeys.attention.rawValue.localizeString()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "ShoppingPaymentView", bundle: nil)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.shoppingViewButtonAction()
    }
}


