//
//  LocalProductsViewController.swift
//  Tourism app
//
//  Created by Rafi on 13/10/2022.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
        
        fetch(route: .fetchProductByDistrict, method: .post, parameters: ["district_id": exploreDistrict?.id ?? 0], model: ProductModel.self)
    }
    
    func updateUI() {
        thumbnailTopLabel.text = exploreDistrict?.title
        thumbnail.sd_setImage(with: URL(string: Route.baseUrl + (exploreDistrict?.thumbnailImage ?? "")))
    }
    
    func fetch<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type) {
        URLSession.shared.request(route: route, method: method, parameters: parameters, model: model) { result in
            switch result {
            case .success(let product):
                DispatchQueue.main.async {
                    self.productDetail = product as? ProductModel
                    self.collecttionView.reloadData()
                }
            case .failure(let error):
                if error == .noInternet {
                    self.collecttionView.noInternet()
                }
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
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 5
        let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: width, height: width)
    }
}


