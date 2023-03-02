//
//  PostViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/28/23.
//

import UIKit
import Alamofire
class PostViewController: UIViewController, UINavigationControllerDelegate {

    var postType: PostType?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var imagePicker: UIImagePickerController!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch postType {
        case .post:
            label.text = "Create Post"
        case .story:
            label.text = "Highlight"
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
        self.dismiss(animated: true)
    }
    
    @IBAction func postBtnAction(_ sender: Any) {
        guard let text = textView.text else { return }
        Networking.shared.uploadMultipart(route: .postApi, image: imageView.image ?? UIImage(), parameters: ["description": text]) { result in
            switch result {
            case .success(let success):
                if success.success == true{
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
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
