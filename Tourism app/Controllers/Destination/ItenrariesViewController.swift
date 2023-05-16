//
//  ItenrariesViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SVProgressHUD
class ItenrariesViewController: BaseViewController {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ItenrariesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ItenrariesCollectionViewCell.cellIdentifier)
        }
    }
    var locationCategory: LocationCategory?
    var ItinraryDetail: ItinraryModel?
    var exploreDistrict: ExploreDistrict?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(route: .fetchItinraries, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: ItinraryModel.self)
                //id = 5
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = attractionDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(route: .fetchItinraries, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0], model: ItinraryModel.self)
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions?.title
            thumbnailBottomLabel.text = archeology?.attractions?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")))
            fetch(route: .fetchItinraries, method: .post, parameters: ["district_id": archeology?.id ?? 0], model: ItinraryModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let itinraries):
                self.ItinraryDetail = itinraries as? ItinraryModel
                self.ItinraryDetail?.itineraries?.count == 0 ? self.collectionView.setEmptyView("No Record found!") : self.collectionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}

extension ItenrariesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItinraryDetail?.itineraries?.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItenrariesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItenrariesCollectionViewCell.cellIdentifier, for: indexPath) as! ItenrariesCollectionViewCell
        cell.itinrary = ItinraryDetail?.itineraries?.rows[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let ItinraryDetail = ItinraryDetail?.itineraries?.rows[indexPath.row] else { return }
        Switcher.goToItinraryDetail(delegate: self, itinraryDetail: ItinraryDetail)
    }
}

extension ItenrariesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 5, cellsAcross: 2)
    }
}


