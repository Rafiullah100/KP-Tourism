//
//  PostViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/28/23.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
class PostViewController: UIViewController, UINavigationControllerDelegate {

    var postType: PostType?
    var feed: FeedModel?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var captionView: UIView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch postType {
        case .post:
            label.text = "Create Post"
            postButton.setTitle("Post", for: .normal)
        case .story:
            captionView.isHidden = true
            label.text = "Highlight"
            postButton.setTitle("Create story", for: .normal)
        case .edit:
            label.text = "Edit Post"
            postButton.setTitle("Edit Post", for: .normal)
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (feed?.post?.post_files?[0].image_url ?? "")))
            textView.text = feed?.post?.description
        default:
            label.text = "Create Post"
        }

        guard let profileImage = UserDefaults.standard.profileImage, profileImage.contains("https") else {
            profileImageView.sd_setImage(with: URL(string: Route.baseUrl + (UserDefaults.standard.profileImage ?? "")))
            return }
        profileImageView.sd_setImage(with: URL(string: UserDefaults.standard.profileImage ?? ""))
    }
    
    @IBAction func galleryImageBtnAction(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.loadFeed), object: nil)

        self.dismiss(animated: true)
    }
    
    @IBAction func postBtnAction(_ sender: Any) {
        switch postType {
        case .post:
            guard let text = textView.text else { return }
            createPost(route: .postApi, params: ["description": text, "type": "image"])
        case .edit:
            guard let text = textView.text else { return }
            createPost(route: .editPost, params: ["description": text, "id": feed?.post_id ?? 0, "type": "image"])
        case .story:
            createPost(route: .createStory, params: [:])
        default:
            print("")
        }
    }
    
    private func createPost(route: Route, params: [String: Any]){
        Networking.shared.uploadMultipart(route: route, imageParameter: "images", image: imageView.image ?? UIImage(), parameters: params) { result in
            switch result {
            case .success(let success):
                print(success)
                if success.success == true{
                    if self.postType == .post{
                        SVProgressHUD.showSuccess(withStatus: "Post created.")
                    }
                    else if self.postType == .edit{
                        SVProgressHUD.showSuccess(withStatus: "Post edited.")
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.loadFeed), object: nil)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func update_photo() {
                
//        let urlStr = "https://staging-admin.kptourism.com/api/mobile/users/create_post?images&description"
//        let url = URL(string: urlStr)!
////        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: url)
//        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
//        let parameter: [String: String] = ["description": "This is my post"]
//
//        let headers: HTTPHeaders = [
//            "Content-type": "multipart/form-data"
//        ]
//
//        let file: String = String(format: "file.jpg")
//        let URL = try! URLRequest(url: url, method: .post, headers: headers)
//
//        AF.upload(multipartFormData: { multipartFormData in
//
//            for (key, value) in parameter {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            multipartFormData.append(imageData!, withName: "images", fileName: file, mimeType: "image/jpg")
//        }, to: urlStr)
//        .responseDecodable(of: SuccessModel.self) { response in
//
//        }
    }
    
}


extension PostViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
