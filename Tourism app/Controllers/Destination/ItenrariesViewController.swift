//
//  ItenrariesViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
            fetch(route: .fetchItinraries, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: ItinraryModel.self)
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
            fetch(route: .fetchItinraries, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0], model: ItinraryModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let itinraries):
                DispatchQueue.main.async {
                    self.ItinraryDetail = itinraries as? ItinraryModel
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

extension ItenrariesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItinraryDetail?.itineraries.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItenrariesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItenrariesCollectionViewCell.cellIdentifier, for: indexPath) as! ItenrariesCollectionViewCell
        return cell
    }
}

extension ItenrariesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 5
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width)
    }
}


