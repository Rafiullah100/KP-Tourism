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
    
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messageInputBar.delegate = self
        messagesCollectionView.keyboardDismissMode = .onDrag
        topBarView.addBottomShadow()
        connectSocket()
    }
    
    private func connectSocket(){
        print(Constants.socketIOUrl)
        guard let url = URL(string: Constants.socketIOUrl) else { return }
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socket = manager?.defaultSocket
        socket?.on(clientEvent: .connect) {data, ack in
            print("connection established")
        }
        socket?.connect()
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
            recieverProfileImage.sd_setImage(with: URL(string: Route.baseUrl + (chatUser?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": chatUser?.uuid ?? "", "limit": 1000], model: OnetoOneConversationModel.self)
        }
        else{
            nameLabel.text = chatUser1?.user?.name?.capitalized
            recieverProfileImage.sd_setImage(with: URL(string: Route.baseUrl + (chatUser1?.user?.profileImage ?? "")), placeholderImage: UIImage(named: "user"))
            fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": chatUser1?.user?.uuid ?? "", "limit": 1000], model: OnetoOneConversationModel.self)
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
            avatarView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        }
        else{
            if self.conversation?.count ?? 0 > 0{
                if let imageUrl = URL(string: Route.baseUrl + (self.conversation?[1].imageURL ?? "")) {
                    avatarView.sd_setImage(with: imageUrl, completed: nil)
                }
            }
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
                    print(self.chatUser1?.user?.uuid ?? "")
//                    self.socket?.emit("user-chat-message", with: [self.chatUser1?.user?.uuid ?? "", self.messageInputBar.inputTextView.text ?? ""])

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
