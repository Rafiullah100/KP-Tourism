//
//  OrderView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/5/24.
//

import UIKit
protocol OrderNavigationViewDelegate {
    func back()
}

class OrderView: UIView {
    var delegate: ProductNavigationViewDelegate?

    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var riyalLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "OrderView", bundle: nil)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        riyalLabel.text = LocalizationKeys.riyal.rawValue.localizeString()
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        delegate?.back()
    }
}

