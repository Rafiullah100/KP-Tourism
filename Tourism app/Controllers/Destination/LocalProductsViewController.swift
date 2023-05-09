//
//  LocalProductsViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit
import SVProgressHUD
class LocalProductsViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var collecttionView: UICollectionView!{
        didSet{
            collecttionView.delegate = self
            collecttionView.dataSource = self
            collecttionView.register(UINib(nibName: "DestProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DestProductCollectionViewCell.cellIdentifier)
        }
    }
    var exploreDistrict: ExploreDistrict?
    var productDetail: ProductModel?
    var attractionDistrict: AttractionsDistrict?
    var archeology: Archeology?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(route: .fetchProductByDistrict, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: ProductModel.self)
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = attractionDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(route: .fetchProductByDistrict, method: .post, parameters: ["district_id": attractionDistrict?.id ?? 0], model: ProductModel.self)
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions?.title
//            thumbnailBottomLabel.text = archeology?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.image_url ?? "")))
            fetch(route: .fetchProductByDistrict, method: .post, parameters: ["district_id": archeology?.id ?? 0], model: ProductModel.self)
        }
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let product):
                self.productDetail = product as? ProductModel
                self.collecttionView.reloadData()
                self.productDetail?.localProducts.count == 0 ? self.collecttionView.setEmptyView("No Products Found!") : self.collecttionView.reloadData()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc)
    }
}

extension LocalProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail?.localProducts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestProductCollectionViewCell.cellIdentifier, for: indexPath) as! DestProductCollectionViewCell
        cell.product = productDetail?.localProducts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = productDetail?.localProducts[indexPath.row] else { return }
        Switcher.gotoProductDetail(delegate: self, product: product)
    }
}

extension LocalProductsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 5, cellsAcross: 2)
    }
}


