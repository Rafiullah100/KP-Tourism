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
    var otherUser: Sender = Sender(senderId: "other", displayName: "")
    var messages = [MessageType]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var recieverProfileImage: UIImageView!
    
    @IBOutlet weak var typingLabel: UILabel!
    var chatUser: ChatUserRow?
    var conversation: [OnetoOneConversationRow]?
    var chatUser1: LoadedConversation?
    var conversationID: Int?
    var profileImage: String?
    var uuid: String?
    var currentPage = 1
    var limit = 1000
    var totalCount = 0
    
    var typingTimer: Timer?
    var isLoadingData = false
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageInputBar.inputTextView.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messagesCollectionView.transform3D = CATransform3DMakeScale(1, -1, 1)
//        self.collecttionView.collectionViewLayout = InvertedCollectionViewFlowLayout.init()
        self.messageInputBar.delegate = self
        messagesCollectionView.keyboardDismissMode = .onDrag
        topBarView.addBottomShadow()
        registerSocketEvent()
    }
    
    
    private func registerSocketEvent(){
        SocketHelper.shared.typeListening { typing in
            if typing?.lowercased() == "typing..."{
                DispatchQueue.main.async {
                    self.typingLabel.isHidden = false
                    self.typingTimer?.invalidate()
                    self.typingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.stopTyping), userInfo: nil, repeats: false)
                }
            }
        }
        
        DispatchQueue.main.async {
            SocketHelper.shared.getMessage { message, from in
                if from == self.uuid{
                    self.appendMessage(sender: self.otherUser, message: message ?? "", date: "")
                }
            }
        }
    }
    
    @objc func stopTyping() {
        typingLabel.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "Backkk"
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.loadChatUser), object: nil)
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
            userID = chatUser?.id
        }else{
            nameLabel.text = chatUser1?.user?.name?.capitalized
            profileImage = chatUser1?.user?.profileImage ?? ""
            uuid = chatUser1?.user?.uuid
            userID = chatUser1?.user?.id
        }
        recieverProfileImage.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: profileImage ?? "")), placeholderImage: UIImage(named: "user"))
        loadMessages()
    }
    
    private func loadMessages(){
        print(currentPage)
        fetch(route: .onetoOneConversation, method: .post, parameters: ["uuid": uuid ?? "", "page": currentPage,  "limit": limit], model: OnetoOneConversationModel.self)
    }
    
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                let conversationModel = model as? OnetoOneConversationModel
                self.conversation = conversationModel?.chats?.rows ?? []
                if !(self.conversation?.isEmpty ?? true) && self.currentPage == 1{
                    self.conversationID = self.conversation?[0].conversationID
                    self.conversation?.removeLast()
                }
                self.conversation?.forEach({ item in
                    if item.sender?.id == UserDefaults.standard.userID {
                        self.currentUser = Sender(senderId: "self", displayName: item.sender?.name ?? "")
                        guard let currentUser = self.currentUser else { return }
                        self.appendMessage(sender: currentUser, message: item.content ?? "", date: item.createdAt ?? "")
                    }
                    else{
                        self.otherUser = Sender(senderId: "other", displayName: item.sender?.name ?? "")
                        self.appendMessage(sender: self.otherUser, message: item.content ?? "", date: item.createdAt ?? "")
                    }
                })
                self.messages.count == 0 ? self.messagesCollectionView.setEmptyView("No previous conversation exist!") : self.messagesCollectionView.reloadData()
                self.totalCount = conversationModel?.chats?.count ?? 0
                print(self.totalCount, self.messages.count)
                //                if self.currentPage == 1 {
                //                    self.messagesCollectionView.scrollToBottom()
                //                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func sendMessage<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, text: String, model: T.Type) {
        URLSession.shared.request(route: route, method: method, showLoader: false, parameters: parameters, model: model) { result in
            switch result {
            case .success(let message):
                let success = message as? SuccessModel
                if success?.success == true {
                    guard let currentUser = self.currentUser else { return }
                    SocketHelper.shared.sendMessage(uuid: self.uuid ?? "", conversationID: self.conversationID ?? 0, message: text)
                    self.appendMessage(sender: currentUser, message: text, date: "")
                    self.messageInputBar.inputTextView.text = ""
                    self.messageInputBar.inputTextView.resignFirstResponder()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    
    func appendMessage(sender: SenderType, message: String, date: String)  {
        self.messages.append(Message(sender: sender, messageId: "000", sentDate: Helper.shared.dateFromString(date), kind: .text(message)))
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
    }
}

extension ChatViewController{
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
            avatarView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: profileImage ?? "")), placeholderImage: UIImage(named: "user"), completed: nil)
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
        sendMessage(route: .messageAPI, method: .post, parameters: ["message": text, "uuid": uuid ?? "", "conversation_id": self.conversationID ?? 0], text: text, model: SuccessModel.self)
    }
}


extension ChatViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        SocketHelper.shared.typeEmiting(to: uuid ?? "")
        return true
    }
    
}

extension ChatViewController{
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let currentOffset = scrollView.contentOffset.y
            print(currentOffset)
            if currentOffset < 0 {
                if messages.count != totalCount{
                    currentPage = currentPage + 1
                    loadMessages()
                }
            }
        }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let contentOffsetY = scrollView.contentOffset.y
    //        let triggerPoint: CGFloat = 0.0
    //        let tolerance: CGFloat = 10.0
    //
    //        let collectionViewHeight = messagesCollectionView.frame.size.height
    //        let contentHeight = messagesCollectionView.contentSize.height
    //        print(contentHeight, collectionViewHeight)
    //        if isLoadingData || contentHeight < collectionViewHeight {
    //            return
    //        }
    //
    //        if contentOffsetY < triggerPoint + tolerance {
    //            if messages.count != totalCount{
    //                currentPage = currentPage + 1
    //                loadMessages()
    //                isLoadingData = false
    //            }
    //        }
    //    }
}

