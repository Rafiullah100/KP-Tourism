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
    var wishlistAttraction: WishlistAttraction?
    var wishlistDistrict: WishlistDistrict?

    var totalCount = 0
    var currentPage = 1
    var limit = 10
    var productArray: [LocalProduct] = [LocalProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        loadData()
    }
    
    private func loadData(){
        if exploreDistrict != nil {
            thumbnailTopLabel.text = exploreDistrict?.title
            thumbnailBottomLabel.text = exploreDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": exploreDistrict?.id ?? 0, "limit": limit, "page": currentPage])
        }
        else if attractionDistrict != nil{
            thumbnailTopLabel.text = attractionDistrict?.title
            thumbnailBottomLabel.text = attractionDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (attractionDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": attractionDistrict?.districtID ?? 0, "limit": limit, "page": currentPage])
        }
        else if archeology != nil{
            thumbnailTopLabel.text = archeology?.attractions.title
            thumbnailBottomLabel.text = archeology?.attractions.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (archeology?.attractions.displayImage ?? "")))
            fetch(parameters: ["district_id": archeology?.attractions.districtID ?? 0, "limit": limit, "page": currentPage])
        }
        else if wishlistAttraction != nil{
            thumbnailTopLabel.text = wishlistAttraction?.title
            thumbnailBottomLabel.text = wishlistAttraction?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistAttraction?.displayImage ?? "")))
            fetch(parameters: ["district_id": wishlistAttraction?.districtID ?? 0, "limit": limit, "page": currentPage])
        }
        if wishlistDistrict != nil {
            thumbnailTopLabel.text = wishlistDistrict?.title
            thumbnailBottomLabel.text = wishlistDistrict?.locationTitle
            thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (wishlistDistrict?.previewImage ?? "")))
            fetch(parameters: ["district_id": wishlistDistrict?.id ?? 0, "limit": limit, "page": currentPage])
        }
    }
    
    func fetch(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchProductByDistrict, method: .post, parameters: parameters, model: ProductModel.self) { result in
            switch result {
            case .success(let product):
                self.productArray.append(contentsOf: product.localProducts)
                self.totalCount = product.count
                self.totalCount == 0 ? self.collecttionView.setEmptyView("No Products Found!") : self.collecttionView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        add(vc)
    }
}

extension LocalProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DestProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DestProductCollectionViewCell.cellIdentifier, for: indexPath) as! DestProductCollectionViewCell
        cell.product = productArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let product = productDetail?.localProducts[indexPath.row] else { return }
        Switcher.gotoProductDetail(delegate: self, product: productArray[indexPath.row], type: .list)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if productArray.count != totalCount && indexPath.row == productArray.count - 1  {
            currentPage = currentPage + 1
            loadData()
        }
    }
}

extension LocalProductsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 5, cellsAcross: 2)
    }
}


