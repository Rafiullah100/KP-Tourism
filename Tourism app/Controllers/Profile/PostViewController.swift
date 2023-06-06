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
    var wishlistFeed: PostWishlist?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var captionView: UIView!
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var postButtonView: UIView!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.sd_setImage(with: URL(string: Helper.shared.getProfileImage()), placeholderImage: UIImage(named: "user"))
        updateUI()
    }
    
    private func updateUI(){
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
        case .view:
            label.text = "Post"
            textView.isEditable = false
            imageButton.isUserInteractionEnabled = false
            postButtonView.isHidden = true
            textView.text = wishlistFeed?.post.description
            imageView.sd_setImage(with: URL(string: Route.baseUrl + (wishlistFeed?.post.postFiles[0].imageURL ?? "")))
        default:
            label.text = "Create Post"
        }
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
                        self.view.makeToast("Post created.")
                    }
                    else if self.postType == .edit{
                        self.view.makeToast("Post edited.")
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.loadFeed), object: nil)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
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
