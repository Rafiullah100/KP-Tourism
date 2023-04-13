//
//  ChatViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/12/22.
//

import UIKit
import SDWebImage
import SVProgressHUD
import SocketIO
import IQKeyboardManager
import MessageKit
import InputBarAccessoryView
import SDWebImage
class CellIds {
    static let senderCellId = "senderCellId"
    static let receiverCellId = "receiverCellId"
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
    
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate {
    
    var currentUser: Sender?
    var otherUser: Sender?
    var messages = [MessageType]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var recieverProfileImage: UIImageView!

    
    var chatUser: ChatUserRow?
    var conversation: [OnetoOneConversationRow]?
    var chatUser1: LoadedConversation?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messageInputBar.delegate = self
        messagesCollectionView.keyboardDismissMode = .onDrag
        topBarView.addBottomShadow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "Backkk"
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if chatUser != nil {
            nameLabel.text = chatUser?.name
            recieverProfileImage.sd_setImage(with: URL(string: Route.baseUrl + (chatUser?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": chatUser?.uuid ?? "", "limit": 1000], model: OnetoOneConversationModel.self)
        }
        else{
            nameLabel.text = chatUser1?.user?.name
            recieverProfileImage.sd_setImage(with: URL(string: Route.baseUrl + (chatUser1?.user?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": chatUser1?.user?.uuid ?? "", "limit": 1000], model: OnetoOneConversationModel.self)
        }
      
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let conversation):
                self.conversation = (conversation as? OnetoOneConversationModel)?.chats.rows ?? []
                self.conversation?.forEach({ item in
                    if item.sender.id == UserDefaults.standard.userID {
                        self.currentUser = Sender(senderId: "self", displayName: item.sender.name)
                        guard let currentUser = self.currentUser else { return }
                        self.messages.append(Message(sender: currentUser, messageId: "\(item.id)", sentDate: Date().addingTimeInterval(000), kind: .text(item.content)))
                    }
                    else{
                        self.otherUser = Sender(senderId: "other", displayName: item.sender.name)
                        guard let otherUser = self.otherUser else { return }
                        self.messages.append(Message(sender: otherUser, messageId: "\(item.id)", sentDate: Date().addingTimeInterval(000), kind: .text(item.content)))
                    }
                })
                self.messages.count == 0 ? self.messagesCollectionView.setEmptyView("No previous conversation exist!") : self.messagesCollectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func currentSender() -> MessageKit.SenderType {
        return currentUser ?? Sender(senderId: "", displayName: "")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if message.sender.senderId ==  "self"{
            let avatar = Avatar(image: UIImage(named: "user"))
            avatarView.set(avatar: avatar)
        }
        else{
            if let imageUrl = URL(string: Route.baseUrl + (self.conversation?[1].sender.profileImage ?? "")) {
                avatarView.sd_setImage(with: imageUrl, completed: nil)
            }
        }
    }
    
//    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        <#code#>
//    }

    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
          string: name,
          attributes: [
            .font: UIFont(name: Constants.appFontName, size: 12),
            .foregroundColor: UIColor.black
          ]
        )
      }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        if chatUser != nil{
            sendMessage(route: .messageAPI, method: .post, parameters: ["message": text, "conversation_id": chatUser?.id ?? "", "uuid": chatUser?.uuid ?? ""], text: text, model: SuccessModel.self)
        }
        else{
            sendMessage(route: .messageAPI, method: .post, parameters: ["message": text, "conversation_id": chatUser1?.conversationID ?? "", "uuid": chatUser1?.user?.uuid ?? ""], text: text, model: SuccessModel.self)
        }
    }
    
        
    func sendMessage<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, text: String, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let message):
                let success = message as? SuccessModel
                if success?.success == true {
                    guard let currentUser = self.currentUser else { return }
                    self.messages.append(Message(sender: currentUser, messageId: "\(Date())", sentDate: Date().addingTimeInterval(000), kind: .text(text)))
                    self.messageInputBar.inputTextView.text = ""
                    self.messageInputBar.inputTextView.resignFirstResponder()
                    self.messagesCollectionView.reloadData()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

//extension ChatViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.conversation?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if conversation?[indexPath.row].sender.id == UserDefaults.standard.userID{
//            guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIds.receiverCellId, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
//            cell.textView.text = conversation?[indexPath.section].content
//            cell.bottomLabel.text = conversation?[indexPath.row].createdAt
//            return cell
//        }
//        else{
//            guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIds.senderCellId, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
//            cell.textView.text = conversation?[indexPath.section].content
//            cell.bottomLabel.text = conversation?[indexPath.row].createdAt
//            return cell
//        }
//    }
//}

//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//}

//extension ChatViewController: KeyboardInputAccessoryViewProtocol{
////    func scrollView() -> UIScrollView {
////        return UIScrollView()
////    }
//
//    func send(data type: String) {
//        if chatUser != nil{
//            sendMessage(route: .messageAPI, method: .post, parameters: ["message": type, "conversation_id": chatUser?.id ?? "", "uuid": chatUser?.uuid ?? ""], model: SuccessModel.self)
//        }
//        else{
//            SocketHelper.shared.sendMessage(message: "message", withNickname: "name")
////            sendMessage(route: .messageAPI, method: .post, parameters: ["message": type, "conversation_id": chatUser1?.conversationID ?? "", "uuid": chatUser1?.user?.uuid ?? ""], model: SuccessModel.self)
//        }
////        doComment(route: .doComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? "", "comment": type], model: SuccessModel.self)
//    }
//
//
////    func send(textView: UITextView) {
////        commentTextView.resignFirstResponder()
////        textView.resignFirstResponder()
////        commentView.isHidden = false
//////        doComment(route: .doComment, method: .post, parameters: ["blog_id": blogDetail?.id ?? "", "comment": type], model: SuccessModel.self)
////    }
//
//
//
//}
