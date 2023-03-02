//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
class CellIds {
    static let senderCellId = "senderCellId"
    static let receiverCellId = "receiverCellId"
}

class ChatViewController: UIViewController {
    @IBOutlet weak var toolBarHeight: NSLayoutConstraint!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var topBarView: UIView!

    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: CellIds.receiverCellId)
            tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: CellIds.senderCellId)
        }
    }
    
    lazy var customAccessoryView: KeyboardInputAccessoryView = {
        return Bundle.main.loadNibNamed("KeyboardInputAccessoryView", owner: nil)![0] as! KeyboardInputAccessoryView
    }()
    
    var items = ["NayaPay why are you charging Rs 244.97 exchange rate when dollar rate is Rs 224.74 that is very big difference in the rates and very disappointing 😞 as I liked the nayapay service very much. and this is unbearable to pay extra Rs 20 per dollar when the dollar is already at it's peak rate.. 😔😔", "NayaPay why are you charging Rs 244.97 exchange rate", "when dollar rate is Rs 224.74 that is very big difference in the rates", "when the dollar", "in the rates and very disappointing 😞 as I liked the nayapay service very much"]
    let messageTextViewMaxHeight: CGFloat = 100

    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        textView.inputAccessoryView = customAccessoryView
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section % 2 == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.receiverCellId, for: indexPath) as? ChatTableViewCell {
                cell.textView.text = items[indexPath.section]
                cell.showTopLabel = false
                return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.senderCellId, for: indexPath) as? ChatTableViewCell {
                cell.textView.text = items[indexPath.section]
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ChatViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        toolBarView.isHidden = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message.."
            textView.textColor = UIColor.lightGray
        }
    }
}
