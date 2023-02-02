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
    
    var locationCategory: LocationCategory?
    var exploreDistrict: ExploreDistrict?
    var attractionDetail: AttractionModel?
    var attractionDistrict: AttractionsDistrict?

    var attractionDistrictsArray: [AttractionsDistrict] = [AttractionsDistrict]()


    var currentPage = 1
    var totalPages = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        loadData(currentPage: currentPage)
    }
    
    private func loadData(currentPage: Int){
        if exploreDistrict != nil {
            sectionLabel.text = "Attractions"
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0, "type": "attraction", "limit": 5, "page": currentPage], model: AttractionModel.self)
        }
        else if attractionDistrict != nil{
            sectionLabel.text = "What to see"
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.displayImage ?? "")))
            fetch(route: .fetchAttractionByDistrict, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0, "type": "sub_attraction", "limit": 5, "page": currentPage], model: AttractionModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let attractions):
                DispatchQueue.main.async {
                    self.attractionDistrictsArray.append(contentsOf: (attractions as? AttractionModel)?.attractions?.rows ?? [])
                    self.totalPages = (attractions as? AttractionModel)?.attractions?.count ?? 1
                    self.attractionDistrictsArray.count == 0 ? self.collectionView.setEmptyView() : self.collectionView.reloadData()
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
        return attractionDistrictsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestAttractCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestAttractCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DestAttractCollectionViewCell
        cell.attraction = attractionDistrictsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if locationCategory == .district{
            Switcher.goToDestination(delegate: self, type: .tourismSpot, attractionDistrict: attractionDistrictsArray[indexPath.row])
        }
        else if locationCategory == .tourismSpot{
            Switcher.gotoAttractionDetail(delegate: self, attractionDistrict: attractionDistrictsArray[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if totalPages != attractionDistrictsArray.count && indexPath.row == attractionDistrictsArray.count-1  {
            currentPage = currentPage + 1
            loadData(currentPage: currentPage)
        }
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

