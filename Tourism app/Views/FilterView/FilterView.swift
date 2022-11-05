//
//  FilterView.swift
//  Tourism app
//
//  Created by Rafi on 04/11/2022.
//

import UIKit

class FilterView: UIView {

    @IBOutlet weak var containerView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }

    private func commoninit(){
        let customMarkerView = Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)![0] as! UIView
        customMarkerView.frame = self.bounds
        customMarkerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        addSubview(customMarkerView)
    }
    

}
