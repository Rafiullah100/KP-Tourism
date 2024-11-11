//
//  ProductNavigationView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/9/24.
//

import UIKit
protocol ProductNavigationViewDelegate {
    func back()
}
class ProductNavigationView: UIView {
    var delegate: ProductNavigationViewDelegate?
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var leftIconImageView: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "ProductNavigationView", bundle: nil)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        delegate?.back()
    }
}

