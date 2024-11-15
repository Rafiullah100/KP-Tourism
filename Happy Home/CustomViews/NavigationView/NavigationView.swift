//
//  NavigationView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit
protocol NavigationViewDelegate {
    func back()
}

class NavigationView: UIView {
    var delegate: NavigationViewDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @IBOutlet weak var backIcon: UIImageView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "NavigationView", bundle: nil)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        delegate?.back()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backIcon.image = UIImage(named: Helper.shared.isRTL() ? "ar-back-circle-arrow" : "back-circle-arrow")
    }
}

