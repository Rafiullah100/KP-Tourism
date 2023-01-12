//
//  AttractionViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit

class AttractionViewController: BaseViewController {
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "DestAttractCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DestAttractCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var locationCategory: LocationCategory = .district
    var exploreDistrict: ExploreDistrict?
    var attractionDetail: AttractionModel?
    
    var attractionDistrict: AttractionsDistrict?


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: AttractionModel.self)
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0], model: AttractionModel.self)
        }
    }
    
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let attractions):
                DispatchQueue.main.async {
                    self.attractionDetail = attractions as? AttractionModel
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                if error == .noInternet {
                    self.collectionView.noInternet()
                }
            }
        }
    }
}

extension AttractionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attractionDetail?.attractions.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestAttractCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestAttractCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DestAttractCollectionViewCell
        cell.attraction = attractionDetail?.attractions.rows[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.goToDestination(delegate: self, type: locationCategory, attractionDistrict: attractionDetail?.attractions.rows[indexPath.row])
    }
}

extension AttractionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.65)
    }
}

extension AttractionViewController: PopupDelegate{
    func showPopup() {
       // Switcher.gotoFilterVC(delegate: self)
    }
}

