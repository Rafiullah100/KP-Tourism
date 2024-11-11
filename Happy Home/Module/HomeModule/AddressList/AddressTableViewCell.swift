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

    @IBOutlet weak var defaultView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        let unselectedAction = UIAction(title: "Unselected", image: UIImage(systemName: "checkmark.circle")) { action in
            self.didUnselectedTapped?()
        }
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { action in
            self.didEditTapped?()
        }
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash")) { action in
            self.didDeleteTapped?()
        }
        let menu = UIMenu(title: "", children: [unselectedAction, editAction, deleteAction])
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
        
    }
}
