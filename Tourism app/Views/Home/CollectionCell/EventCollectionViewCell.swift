//
//  EventCollectionViewCell.swift
//  Tourism app
//
//  Created by Rafi on 11/10/2022.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier = "event_cell_identifier"

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.cornerRadius = 15.0
        
        statusView.roundCorners(corners: .topLeft, radius: 10.0)
    }
}



