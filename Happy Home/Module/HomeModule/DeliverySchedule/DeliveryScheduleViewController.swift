//
//  DeliveryScheduleViewController.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/3/24.
//

import UIKit

class DeliveryScheduleViewController: UIViewController {

    @IBOutlet weak var shoppingView: ShoppingPaymentView!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var timeCollectionView: UICollectionView!{
        didSet{
            timeCollectionView.delegate = self
            timeCollectionView.dataSource = self
            timeCollectionView.register(UINib(nibName: "DeliveryTimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DeliveryTimeCollectionViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var dayCollectionView: UICollectionView!{
        didSet{
            dayCollectionView.delegate = self
            dayCollectionView.dataSource = self
            dayCollectionView.register(UINib(nibName: "DeliveryDayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DeliveryDayCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var selectedTimeIndexPath: IndexPath?
    var selectedDayIndexPath: IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingView.delegate = self
        navigationView.delegate = self
        shoppingView.shoppingButton.setTitle("Go for Payment", for: .normal)
        navigationView.titleLabel.text = "Add Further Details"
    }
    @IBAction func changeButtonAction(_ sender: Any) {
        Switcher.gotoAddressList(delegate: self)
    }
}

extension DeliveryScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayCollectionView{
            return Constants.days.count
        }
        else{
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dayCollectionView{
            let cell: DeliveryDayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryDayCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DeliveryDayCollectionViewCell
            cell.label.text = Constants.days[indexPath.row]
            cell.configure(isSelected: indexPath == selectedDayIndexPath)
            return cell
        }
        else{
            let cell: DeliveryTimeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryTimeCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! DeliveryTimeCollectionViewCell
            cell.configure(isSelected: indexPath == selectedTimeIndexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dayCollectionView{
            let cellsAcross: CGFloat = 3
            let spaceBetweenCells: CGFloat = 5
            let sectionInset: CGFloat = 5
            let totalPadding = (cellsAcross - 1) * spaceBetweenCells + 2 * sectionInset
            let availableWidth = collectionView.bounds.width - totalPadding
            let width = availableWidth / cellsAcross
            return CGSize(width: width, height: 30)
        }
        else{
            let cellsAcross: CGFloat = 2
            let spaceBetweenCells: CGFloat = 5
            let sectionInset: CGFloat = 5
            let totalPadding = (cellsAcross - 1) * spaceBetweenCells + 2 * sectionInset
            let availableWidth = collectionView.bounds.width - totalPadding
            let width = availableWidth / cellsAcross
            return CGSize(width: width, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dayCollectionView{
            selectedDayIndexPath = indexPath
            dayCollectionView.reloadData()
        }
        else{
            selectedTimeIndexPath = indexPath
            timeCollectionView.reloadData()
        }
    }
}

extension DeliveryScheduleViewController: NavigationViewDelegate{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DeliveryScheduleViewController: ShoppingDelegate{
    func shoppingViewButtonAction() {
        Switcher.gotoPaymentMethod(delegate: self)
    }
}
