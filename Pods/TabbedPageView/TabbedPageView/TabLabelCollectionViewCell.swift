//
//  TabLabelCollectionViewCell.swift
//  TabbedPageView
//
//  Created by Michael Onjack on 12/6/18.
//  Copyright © 2018 Michael Onjack. All rights reserved.
//

import UIKit

class TabLabelCollectionViewCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        var l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = UIColor.clear
        l.textAlignment = .center
        l.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1.0)
        l.adjustsFontSizeToFitWidth = false
        l.font = UIFont(name: "Roboto-regular", size: 12.0)
        
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        setupLayout()
    }
    
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
}
