//
//  InterestPointViewController.swift
//  Tourism app
//
//  Created by Rafi on 12/10/2022.
//

import UIKit
import SDWebImage
class PointOfInterestViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "InterestPointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: InterestPointCollectionViewCell.cellReuseIdentifier())
        }
    }
    var locationCategory: LocationCategory?
    var category: PoiCategoriesModel?
    var district: ExploreDistrict?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
        fetch()
    }
    
    func updateUI() {
        switch locationCategory {
        case .district:
            thumbnailTopLabel.text = "Swat"
            thumbnailBottomLabel.text = "KP"
            thumbnail.image = UIImage(named: "Path 94")
        case .tourismSpot:
            thumbnailTopLabel.text = "Kalam"
            thumbnailBottomLabel.text = "Swat"
            thumbnail.image = UIImage(named: "iten")
        default:
            break
        }
        
        thumbnailTopLabel.text = district?.title
        thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (district?.thumbnailImage ?? "")))
    }
    
    private func fetch() {
        URLSession.shared.request(route: .fetchPoiCategories, method: .post, model: PoiCategoriesModel.self) { result in
            switch result {
            case .success(let poiCategory):
                DispatchQueue.main.async {
                    self.category = poiCategory
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
      
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc)
    }
}

extension PointOfInterestViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.poicategories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: InterestPointCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestPointCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! InterestPointCollectionViewCell
        cell.poiCategory = category?.poicategories[indexPath.row]
        return cell
    }
}

extension PointOfInterestViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let district = district, let poiCategoryId = category?.poicategories[indexPath.row].id else { return }
        Switcher.goToPOIServices(delegate: self, locationCategory: locationCategory!, district: district, poiCategoryId: poiCategoryId)
    }
}

extension PointOfInterestViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 2, cellsAcross: 4)
    }
}
