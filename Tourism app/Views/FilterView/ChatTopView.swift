//
//  ChatTopView.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/21/23.
//

import UIKit

protocol ChatProtocol {
    func popView()
}

class ChatTopView: UIView {
    var backButtonHandler: (() -> Void)?
    var delegate: ChatProtocol? = nil
    
    
    @IBOutlet weak var typingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func backBtnAction(_ sender: Any) {
        delegate?.popView()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
