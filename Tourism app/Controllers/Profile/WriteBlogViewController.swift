//
//  WriteBlogViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/21/23.
//

import UIKit
import SVProgressHUD
class WriteBlogViewController: UIViewController, UINavigationControllerDelegate {

    enum BlogApiType {
        case district
        case attraction
        case poi
    }
    
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var poiTextField: UITextField!
    @IBOutlet weak var attractionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    
    var dispatchGroup: DispatchGroup?
    var districtList: [DistrictsListRow]?
    var Poicategory: [Poicategory]?
    var attractionArray: [AttractionsDistrict]?
    
    let districtPickerView = UIPickerView()
    let poiPickerView = UIPickerView()
    let attractionPickerView = UIPickerView()

    var poiID: Int?
    var districtID: Int?
    var attractionID: Int?
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
        poiPickerView.delegate = self
        poiPickerView.dataSource = self
        attractionPickerView.delegate = self
        attractionPickerView.dataSource = self
        districtTextField.inputView = districtPickerView
        poiTextField.inputView = poiPickerView
        attractionTextField.inputView = attractionPickerView

        dispatchGroup?.enter()
        fetch(route: .districtListApi, method: .post, parameters: ["limit": 50], model: DistrictListModel.self, apiType: .district)
        dispatchGroup?.leave()
        dispatchGroup?.enter()
        fetch(route: .fetchPoiCategories, method: .post, model: PoiCategoriesModel.self, apiType: .poi)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, apiType: BlogApiType) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let model):
                if apiType == .district{
                    self.districtList = (model as! DistrictListModel).districts?.rows
                    self.districtPickerView.reloadAllComponents()
                }
                else if apiType == .poi{
                    self.Poicategory = (model as! PoiCategoriesModel).poicategories
                    self.poiPickerView.reloadAllComponents()
                    print(self.Poicategory?.count ?? 0)
                }
                else{
                    self.attractionArray = (model as! AttractionModel).attractions?.rows
                    self.attractionPickerView.reloadAllComponents()
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    
    
    @IBAction func takeImageBtn(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveBlogBtn(_ sender: Any) {
        guard let title = titleTextField.text, let districtID = districtID, let attractionID = attractionID, let poiID = poiID, let descriptin = textView.text else { return }
        createPost(route: .addBlog, params: ["title": title, "description": descriptin, "district_id": districtID, "attraction_id": attractionID, "poi_id": poiID])
    }
    
    private func createPost(route: Route, params: [String: Any]){
        Networking.shared.uploadMultipart(route: route, imageParameter: "images", image: blogImageView.image ?? UIImage(), parameters: params) { result in
            switch result {
            case .success(let success):
                print(success)
                if success.success == true{
                    self.dismiss(animated: true) {
                        SVProgressHUD.showSuccess(withStatus: "Blog successfully added.")
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

extension WriteBlogViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == districtPickerView{
            return districtList?.count ?? 0
        }
        else if pickerView == poiPickerView{
            return Poicategory?.count ?? 0
        }
        else{
            return attractionArray?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == districtPickerView{
            return districtList?[row].title
        }
        else if pickerView == poiPickerView{
            return Poicategory?[row].title
        }
        else{
            return attractionArray?[row].title
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == districtPickerView{
            attractionTextField.text = ""
            districtID = districtList?[row].id
            districtTextField.text = districtList?[row].title
            guard let districtID = districtID else { return }
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": districtID], model: AttractionModel.self, apiType: .attraction)
        }
        else if pickerView == poiPickerView{
            poiID = Poicategory?[row].id
            poiTextField.text = Poicategory?[row].title
        }
        else{
            attractionID = attractionArray?[row].id
            attractionTextField.text = attractionArray?[row].title
        }
    }
}

extension WriteBlogViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            blogImageView.contentMode = .scaleToFill
            blogImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
