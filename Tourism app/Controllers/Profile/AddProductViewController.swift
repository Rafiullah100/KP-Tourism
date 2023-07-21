//
//  AddProductViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/21/23.
//

import UIKit
import SVProgressHUD
class AddProductViewController: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    let districtPickerView = UIPickerView()
    var districtList: [DistrictsListRow]?
    var imagePicker: UIImagePickerController!
    var districtID: Int?

    var product: UserProductRow?
    var postType: PostType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = product?.title
        textView.text = product?.description
        priceTextField.text = "\(product?.price ?? 0)"
        blogImageView.sd_setImage(with: URL(string: Route.baseUrl + (product?.previewImage ?? "")))
        topLabel.text = postType == .post ? "Add Product" : "Edit Product"
        
        blogImageView.isHidden = true
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
        districtTextField.inputView = districtPickerView
        fetch(route: .districtListApi, method: .post, parameters: ["limit": 50], model: DistrictListModel.self)
    }
    
    @IBAction func takeImageBtn(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        dataTask = URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                self.districtList = (model as! DistrictListModel).districts?.rows
                self.districtPickerView.reloadAllComponents()
                if self.postType == .edit{
                    self.findDistrictObject()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func findDistrictObject(){
        if let index = districtList?.firstIndex(where: { $0.id ==  product?.districtID }) {
            districtTextField.text = districtList?[index].title
            districtID = districtList?[index].id
        }
    }
    
    @IBAction func saveBlogBtn(_ sender: Any) {
        guard let title = titleTextField.text,  let districtID = districtID, let price = priceTextField.text,  let descriptin = textView.text else { return }
        if postType == .post{
            createPost(route: .addProduct, params: ["title": title, "description": descriptin, "district_id": districtID, "price": price])
        }
        else if postType == .edit{
            createPost(route: .updateProduct, params: ["id": product?.id ?? 0, "title": title, "description": descriptin, "district_id": districtID, "price": price, "old_preview_image_path": product?.previewImage ?? "", "old_thumnail_image_path": product?.thumbnailImage ?? ""])
        }
    }
    
    private func createPost(route: Route, params: [String: Any]){
        print(params)
        Networking.shared.uploadMultipart(route: route, imageParameter: "images", image: blogImageView.image ?? UIImage(), parameters: params) { result in
            switch result {
            case .success(let success):
                if success.success == true{
                    self.dismiss(animated: true) {
                        SVProgressHUD.showSuccess(withStatus: success.message)
                    }
                }
                else{
                    SVProgressHUD.showError(withStatus: success.message)
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}


extension AddProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return districtList?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return districtList?[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            districtID = districtList?[row].id
            districtTextField.text = districtList?[row].title
    }
}


extension AddProductViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            blogImageView.contentMode = .scaleToFill
            blogImageView.image = pickedImage
            if let imageURL = info[.imageURL] as? URL {
                let imageName = imageURL.lastPathComponent
                imageNameLabel.text = imageName
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
