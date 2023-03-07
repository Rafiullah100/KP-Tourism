//
//  ExperienceViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/30/23.
//

import UIKit

class VisitExperienceCollectionViewCell: UICollectionViewCell {
    //
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var selectedImgView: UIImageView!

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageBG: UIView!
    var experience: DistrictCategorory? {
        didSet {
            label.text = experience?.title
            bgImageView.sd_setImage(with: URL(string: Route.baseUrl + (experience?.icon ?? "")))
            
            bottomView.clipsToBounds = true
            bottomView.layer.cornerRadius = 10
            bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            imageBG.clipsToBounds = true
            imageBG.layer.cornerRadius = 10
            imageBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.viewShadow()

        }
    }
    override var isSelected: Bool{
        didSet{
            selectedImgView.isHidden = isSelected ? false : true
        }
    }
    
    
}

class ExperienceViewController: BaseViewController {

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var collectionViewHeigh: NSLayoutConstraint!
   
    var districtCategries: [DistrictCategorory]?
    var isSelected: Bool?
    var experienceId: Int?
    var geoTypeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .visitKP
        viewControllerTitle = "Tour Planner"
        fetch(route: .districtCategoriesApi, method: .post, model: DistrictCatModel.self)
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let category):
                DispatchQueue.main.async {
                    self.districtCategries = (category as! DistrictCatModel).districtCategorories
                    self.collectionViewHeigh.constant = CGFloat.greatestFiniteMagnitude
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()
                    self.collectionViewHeigh.constant = self.collectionView.contentSize.height
                }
            case .failure(let error):
                if error == .noInternet {
                    self.collectionView.noInternet()
                }
            }
        }
    }
    
    @IBAction func forwardBtnAction(_ sender: Any) {
        if isSelected == true{
            Switcher.gotoTourDestinationVC(delegate: self, experienceID: experienceId ?? 0, geoTypeID: geoTypeId ?? "")
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ExperienceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return districtCategries?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: VisitExperienceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! VisitExperienceCollectionViewCell
        cell.experience = districtCategries?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        Switcher.gotoTourDestinationVC(delegate: self)
        experienceId = districtCategries?[indexPath.row].id
        isSelected = true
        UserDefaults.standard.experience = districtCategries?[indexPath.row].title
    }
    
}

extension ExperienceViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 10, cellsAcross: 2)
    }
}
