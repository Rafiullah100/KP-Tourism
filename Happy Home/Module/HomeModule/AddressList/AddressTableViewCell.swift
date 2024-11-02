//
//  AddressTableViewCell.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/2/24.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

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
            print("Unselected tapped")
        }
        let editAction = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { action in
            print("Edit tapped")
        }
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash")) { action in
            print("Delete tapped")
        }
        let menu = UIMenu(title: "", children: [unselectedAction, editAction, deleteAction])
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
        
    }
}
