//
//  POIServicesViewController.swift
//  Tourism app
//
//  Created by Rafi on 07/11/2022.
//

import UIKit

class POIServicesViewController: BaseViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet public weak var thumbnailBottomLabel: UILabel!
    @IBOutlet weak var thumbnailTopLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var locationCategory: LocationCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        updateUI()
    }
    
//    override func show(_ vc: UIViewController, sender: Any?) {
//        add(vc)
//    }
    
    
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
    }
}


extension POIServicesViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: POIServiceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier", for: indexPath) as! POIServiceTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
}
