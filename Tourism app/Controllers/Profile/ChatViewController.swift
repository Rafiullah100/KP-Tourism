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
    var uuid: String
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate, MessageCellDelegate {
    
    var currentUser: Sender?
    var otherUser: Sender = Sender(senderId: "other", displayName: "")
    var messages = [MessageType]()
    
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
    
    var chatTopView = ChatTopView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageInputBar.inputTextView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messagesCollectionView.messageCellDelegate = self
        self.messagesCollectionView.showsVerticalScrollIndicator = false
//        self.messagesCollectionView.transform3D = CATransform3DMakeScale(1, -1, 1)
//        self.collecttionView.collectionViewLayout = InvertedCollectionViewFlowLayout.init()
        self.messageInputBar.delegate = self
        messagesCollectionView.keyboardDismissMode = .onDrag
        chatTopView.backButtonHandler = {
            self.navigationController?.popViewController(animated: true)
        }
        registerSocketEvent()
    }
    
    private func registerSocketEvent(){
        SocketHelper.shared.typeListening { typing in
            if typing?.lowercased() == "typing..."{
                DispatchQueue.main.async {
                    self.chatTopView.typingLabel.isHidden = false
                    self.typingTimer?.invalidate()
                    self.typingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.stopTyping), userInfo: nil, repeats: false)
                }
            }
        }
        
        DispatchQueue.main.async {
            SocketHelper.shared.getMessage { message, from in
                if from == self.uuid{
                    self.appendMessage(sender: self.otherUser, message: message ?? "", date: "", messageID: String(0), uuid: "")
                }
            }
        }
    }
    
    @objc func stopTyping() {
        chatTopView.typingLabel.isHidden = true
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
        addCustomView()
        if chatUser != nil {
            chatTopView.nameLabel.text = chatUser?.name?.capitalized
            profileImage = chatUser?.profileImage ?? ""
            uuid = chatUser?.uuid
            userID = chatUser?.id
        }else{
            chatTopView.nameLabel.text = chatUser1?.user?.name?.capitalized
            profileImage = chatUser1?.user?.profileImage ?? ""
            uuid = chatUser1?.user?.uuid
            userID = chatUser1?.user?.id
        }
        chatTopView.imageView.sd_setImage(with: URL(string: Helper.shared.getOtherProfileImage(urlString: profileImage ?? "")), placeholderImage: UIImage(named: "user"))
        loadMessages()
    }
    
    private func addCustomView(){
        let topView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 90)))
        view.addSubview(topView)
        chatTopView = Bundle.main.loadNibNamed("ChatTopView", owner: self, options: nil)![0] as! ChatTopView
        topView.addSubview(chatTopView)
        topView.addBottomShadow()
        chatTopView.delegate = self
        chatTopView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chatTopView.topAnchor.constraint(equalTo: topView.topAnchor),
            chatTopView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            chatTopView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            chatTopView.bottomAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
        chatTopView.frame = topView.bounds
        chatTopView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        messagesCollectionView.contentInset.top = 50
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
                    self.conversation?.removeFirst()
                }
                self.conversation?.forEach({ item in
                    if item.sender?.id == UserDefaults.standard.userID {
                        self.currentUser = Sender(senderId: "self", displayName: item.sender?.name ?? "")
                        guard let currentUser = self.currentUser else { return }
                        self.appendMessage(sender: currentUser, message: item.content ?? "", date: item.createdAt ?? "", messageID: String(item.id ?? 0), uuid: UserDefaults.standard.uuid ?? "")
                    }
                    else{
                        self.otherUser = Sender(senderId: "other", displayName: item.sender?.name ?? "")
                        self.appendMessage(sender: self.otherUser, message: item.content ?? "", date: item.createdAt ?? "", messageID: String(item.id ?? 0), uuid: "")
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
                    self.appendMessage(sender: currentUser, message: text, date: "", messageID: String(0), uuid: UserDefaults.standard.uuid ?? "")
                    self.messageInputBar.inputTextView.text = ""
                    self.messageInputBar.inputTextView.resignFirstResponder()
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func appendMessage(sender: SenderType, message: String, date: String, messageID: String, uuid: String)  {
        self.messages.append(Message(sender: sender, messageId: messageID, sentDate: Helper.shared.dateFromString(date), kind: .text(message), uuid: uuid))
        print(self.messages)
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else { return }
        let section = indexPath.section
        let messageID = self.messages[section].messageId
        let uuid = self.messages[section].uuid
        guard uuid == UserDefaults.standard.uuid else {return}
        Utility.showAlert(message: "Are you sure you want to delete this message?", buttonTitles: ["No", "Yes"]) { responce in
            if responce == "Yes"{
                self.deleteMessage(parameters: ["conversation_id": self.conversationID ?? 0, "message_id": messageID], index: section)
            }
        }
    }
    
    func deleteMessage(parameters: [String: Any], index: Int) {
        URLSession.shared.request(route: .deleteMessage, method: .post, showLoader: true, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let res):
                if res.success == true{
                    self.messages.remove(at: index)
                    self.messagesCollectionView.reloadData()
                }
                self.view.makeToast(res.message)
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
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


extension ChatViewController: ChatProtocol{
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

