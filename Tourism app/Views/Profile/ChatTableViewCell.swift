//
//  CustomTableViewCell.swift
//  SSChat
//
//  Created by Sai Sandeep on 03/12/19.
//  Copyright © 2019 Sai Sandeep. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var bgView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var topLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var bottomLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var statusLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var textView: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//    var showTopLabel = true {
//        didSet {
//            textviewTopConstraintToBg.isActive = !showTopLabel
//            textviewTopConstraintToTopLabel.isActive = showTopLabel
//            topLabel.isHidden = !showTopLabel
//        }
//    }
    
    let extraSpacing: CGFloat = 0
    
    let innerSpacing: CGFloat = 2
    
    let padding: CGFloat = 8
    
    let secondaryPadding: CGFloat = 1
    
    var textviewTopConstraintToBg: NSLayoutConstraint!
    
    var textviewTopConstraintToTopLabel: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        if let id = reuseIdentifier {
            if id == CellIds.senderCellId {
                self.setupSendersCell()
            }else {
                self.setupReceiversCell()
            }
        }
    }
    
    func setupSendersCell() {
        let offset = UIEdgeInsets(top: padding, left: padding, bottom: -padding, right: -padding)
        self.contentView.addSubview(bgView)
        bgView.edges([.right, .top, .bottom], to: self.contentView, offset: offset)
        bgView.layer.cornerRadius = 10.0
        bgView.backgroundColor = UIColor(displayP3Red: 0, green: 122/255, blue: 255/255, alpha: 0.9)
        
        self.bgView.addSubview(textView)
        textView.edges([.left, .right, .top], to: self.bgView, offset: .init(top: innerSpacing, left: innerSpacing, bottom: -innerSpacing, right: -innerSpacing))
        bgView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: extraSpacing).isActive = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont(name: "\(Constants.appFontName)-Regular", size: 14.0)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        
        self.bgView.addSubview(bottomLabel)
        bottomLabel.edges([.left, .bottom], to: self.bgView, offset: UIEdgeInsets(top: innerSpacing, left: secondaryPadding, bottom: -secondaryPadding, right: 0))
        bottomLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -secondaryPadding).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: -2).isActive = true
        bottomLabel.font = UIFont.systemFont(ofSize: 10)
        bottomLabel.textColor = UIColor.white
        bottomLabel.textAlignment = .right
        bottomLabel.text = "12:00 AM"
    }
    
    func setupReceiversCell() {
        let offset = UIEdgeInsets(top: padding, left: padding, bottom: -padding, right: -padding)
        self.contentView.addSubview(bgView)
        bgView.edges([.left, .top, .bottom], to: self.contentView, offset: offset)
        bgView.layer.cornerRadius = 10
        bgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        
        self.bgView.addSubview(topLabel)
        topLabel.edges([.left, .top], to: self.bgView, offset: UIEdgeInsets(top: secondaryPadding, left: secondaryPadding, bottom: 0, right: 0))
        topLabel.font = UIFont.boldSystemFont(ofSize: 14)
        topLabel.textColor = UIColor.red
        topLabel.text = "Red"
        
        self.bgView.addSubview(textView)
        textviewTopConstraintToTopLabel = textView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 0)
        textviewTopConstraintToTopLabel.isActive = true
        textviewTopConstraintToBg = textView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: innerSpacing)
        textviewTopConstraintToBg.isActive = false
        textView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: innerSpacing).isActive = true
        textView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -innerSpacing).isActive = true
        topLabel.trailingAnchor.constraint(lessThanOrEqualTo: textView.trailingAnchor, constant: 0).isActive = true
        bgView.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -extraSpacing).isActive = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont(name: "\(Constants.appFontName)-Regular", size: 14.0)
        textView.backgroundColor = UIColor.clear
        self.bgView.addSubview(bottomLabel)
        bottomLabel.edges([.left, .bottom], to: self.bgView, offset: UIEdgeInsets(top: innerSpacing, left: secondaryPadding, bottom: -secondaryPadding, right: 0))
        bottomLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -secondaryPadding).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: -2).isActive = true
        bottomLabel.font = UIFont.systemFont(ofSize: 10)
        bottomLabel.textColor = UIColor.lightGray
        bottomLabel.textAlignment = .right
        bottomLabel.text = "12:00 AM"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
