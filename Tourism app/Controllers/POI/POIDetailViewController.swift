//
//  POIDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/12/23.
//

import UIKit
import SDWebImage
class POIDedetailCell: UICollectionViewCell {
    //
    @IBOutlet weak var imgView: UIImageView!
}

class POIDetailViewController: BaseViewController {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    var poiDetail: POISubCatoryModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(poiDetail?.poiGalleries)
        type = .back1
        descriptionLabel.text = poiDetail?.description.stripOutHtml()
        placeLabel.text = poiDetail?.locationTitle
        categoryLabel.text = poiDetail?.poiCategories.title
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Roboto-Medium", size: 16) ?? UIFont()]
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Roboto-Light", size: 12) ?? UIFont()]
        let name = NSMutableAttributedString(string: "\(poiDetail?.title ?? "") | ", attributes: firstAttributes)
        let poi = NSMutableAttributedString(string: "Point Of Interest", attributes: secondAttributes)
        name.append(poi)
        nameLabel.attributedText = name
    }
}

extension POIDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poiDetail?.poiGalleries.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: POIDedetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! POIDedetailCell
        cell.imgView.sd_setImage(with: URL(string: Route.baseUrl + (poiDetail?.poiGalleries[indexPath.row].imageURL ?? "")))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Switcher.gotoViewerVC(delegate: self, position: indexPath, poiGallery: poiDetail?.poiGalleries, type: .poi)
    }
}

extension POIDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Helper.shared.cellSize(collectionView: collectionView, space: 10, cellsAcross: 2)
    }
}
