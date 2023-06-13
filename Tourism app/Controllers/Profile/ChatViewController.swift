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
    
    @IBOutlet weak var typingLabel: UILabel!
    var chatUser: ChatUserRow?
    var conversation: [OnetoOneConversationRow]?
    var chatUser1: LoadedConversation?
    
    var manager = SocketManager(socketURL: URL(string: Constants.socketIOUrl)!, config: [.log(true), .compress])
    var socket: SocketIOClient?
    
    var profileImage: String?
    var uuid: String?
    var currentPage = 0
    var limit = 20
    var isLoadingMoreMessages = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageInputBar.inputTextView.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messageInputBar.delegate = self
        messagesCollectionView.keyboardDismissMode = .onDrag
        topBarView.addBottomShadow()
        DispatchQueue.main.async {
            SocketHelper.shared.typeListening { typing in
                self.typingLabel.isHidden = false
            }
        }
        DispatchQueue.main.async {
            SocketHelper.shared.getMessage { message in
                self.messages.append(Message(sender: self.otherUser!, messageId: "000", sentDate: Date().addingTimeInterval(000), kind: .text(message ?? "")))
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom()
            }
        }
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
            nameLabel.text = chatUser?.name?.capitalized
            profileImage = chatUser?.profileImage ?? ""
            uuid = chatUser?.uuid
            uuid = ""
        }else{
            nameLabel.text = chatUser1?.user?.name?.capitalized
            profileImage = chatUser1?.user?.profileImage ?? ""
            uuid = chatUser1?.user?.uuid
        }
        recieverProfileImage.sd_setImage(with: URL(string: Route.baseUrl + (profileImage ?? "")), placeholderImage: UIImage(named: "user"))
        loadMessages()
    }
    
    private func loadMessages(){
        guard !isLoadingMoreMessages else {
            return
        }
        fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": uuid ?? "", "page": currentPage,  "limit": limit], model: OnetoOneConversationModel.self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard scrollView.contentOffset.y < 0 else {
                return
            }

            let topInset = scrollView.contentInset.top
            let offsetY = scrollView.contentOffset.y + topInset

            if offsetY < 50 {
                currentPage = currentPage + 1
                loadMessages()
            }
        }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let conversation):
                self.conversation = (conversation as? OnetoOneConversationModel)?.chats?.rows ?? []
                self.conversation?.forEach({ item in
                    if item.sender?.id == UserDefaults.standard.userID {
                        self.currentUser = Sender(senderId: "self", displayName: item.sender?.name ?? "")
                        guard let currentUser = self.currentUser else { return }
                        self.messages.append(Message(sender: currentUser, messageId: "\(item.id ?? 0)", sentDate: Date().addingTimeInterval(000), kind: .text(item.content ?? "")))
                    }
                    else{
                        self.otherUser = Sender(senderId: "other", displayName: item.sender?.name ?? "")
                        guard let otherUser = self.otherUser else { return }
                        self.messages.append(Message(sender: otherUser, messageId: "\(item.id ?? 0)", sentDate: Date().addingTimeInterval(000), kind: .text(item.content ?? "")))
                    }
                })
                self.messages.count == 0 ? self.messagesCollectionView.setEmptyView("No previous conversation exist!") : self.messagesCollectionView.reloadData()
                if self.currentPage == 0 {
                    self.messagesCollectionView.scrollToBottom()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
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
            avatarView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        }
        else{
            avatarView.sd_setImage(with: URL(string: Route.baseUrl + (profileImage ?? "")), placeholderImage: UIImage(named: "user"), completed: nil)
        }
    }

    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
          string: name,
          attributes: [
            .font: UIFont(name: Constants.appFontName, size: 12) ?? UIFont(),
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
                    SocketHelper.shared.sendMessage(message: self.messageInputBar.inputTextView.text ?? "", to: self.chatUser1?.user?.uuid ?? "")
                    self.messages.append(Message(sender: currentUser, messageId: "\(Date())", sentDate: Date().addingTimeInterval(000), kind: .text(text)))
                    self.messageInputBar.inputTextView.text = ""
                    self.messageInputBar.inputTextView.resignFirstResponder()
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()
                    
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}


extension ChatViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        SocketHelper.shared.typeEmiting(to: uuid ?? "")
        return true
    }
    
}
