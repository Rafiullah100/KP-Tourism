//
//  ItinraryDaysTableViewCell.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/8/23.
//

import UIKit

class ItinraryDaysTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var toPlaceDescLabel: UILabel!
    @IBOutlet weak var toPlaceLabel: UILabel!
    @IBOutlet weak var fromPlaceDescLabel: UILabel!
    @IBOutlet weak var fromPlaceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var activity: ItinraryActivity? {
        didSet {
            dayLabel.text = "DAY \(activity?.day ?? 1)"
            dateLabel.text = activity?.departureDate
            fromPlaceLabel.text = "\(activity?.fromPlace ?? "")"
            toPlaceLabel.text = "\(activity?.toPlace ?? "")"
            fromPlaceDescLabel.text = "\(activity?.departureTime ?? "") START JOURNEY FROM \(activity?.fromPlace ?? "")"
            toPlaceDescLabel.text = "00 REACH \(activity?.toPlace ?? "")"
            descriptionLabel.text = "\(activity?.fromPlace ?? "") to \(activity?.toPlace ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
