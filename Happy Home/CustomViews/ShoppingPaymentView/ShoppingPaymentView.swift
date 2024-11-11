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
    
    @IBOutlet weak var shoppingButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
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


