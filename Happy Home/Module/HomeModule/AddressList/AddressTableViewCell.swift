//
//  AddressTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    var didUnselectedTapped: (() -> Void)?
    var didEditTapped: (() -> Void)?
    var didDeleteTapped: (() -> Void)?

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var addressPlace: UILabel!
    @IBOutlet weak var defaultView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        addressPlace.text = LocalizationKeys.office.rawValue.localizeString()
        defaultLabel.text = LocalizationKeys.Default.rawValue.localizeString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        let unselectedAction = UIAction(title: LocalizationKeys.unselected.rawValue.localizeString(), image: UIImage(systemName: "checkmark.circle")) { action in
            self.didUnselectedTapped?()
        }
        let editAction = UIAction(title: LocalizationKeys.edit.rawValue.localizeString(), image: UIImage(systemName: "pencil")) { action in
            self.didEditTapped?()
        }
        let deleteAction = UIAction(title: LocalizationKeys.delete.rawValue.localizeString(), image: UIImage(systemName: "trash")) { action in
            self.didDeleteTapped?()
        }
        let menu = UIMenu(title: "", children: [unselectedAction, editAction, deleteAction])
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
        
    }
}
