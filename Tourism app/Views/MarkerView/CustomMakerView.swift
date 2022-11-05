//
//  CustomMakerView.swift
//  Tourism app
//
//  Created by Rafi on 01/11/2022.
//

import UIKit

class CustomMakerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }

    private func commoninit(){
        let customMarkerView = Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)![0] as! UIView
        customMarkerView.frame = self.bounds
        customMarkerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customMarkerView)
    }
}
