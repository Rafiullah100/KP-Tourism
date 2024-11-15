//
//  SearchView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/4/24.
//

import UIKit

class SearchView: UIView {
        
    @IBOutlet weak var textField: UITextField!
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
        textField.placeholder = LocalizationKeys.searchProductsOrStore.rawValue.localizeString()
        textField.textAlignment = Helper.shared.isRTL() ? .right : .left
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "SearchView", bundle: nil)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
}

