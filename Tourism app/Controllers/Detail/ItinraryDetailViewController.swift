//
//  ItinraryDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/8/23.
//

import UIKit

class ItinraryDetailViewController: BaseViewController {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ItinraryDaysTableViewCell", bundle: nil), forCellReuseIdentifier: ItinraryDaysTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var viewCounterLabel: UILabel!
    
    var itinraryDetail: ItinraryRow?
    var likeCount = 0
    var viewsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.itinraryModelObject = itinraryDetail
        type = .back1
        placeLabel.text = "\(itinraryDetail?.fromDistricts.title ?? "") - \(itinraryDetail?.toDistricts.title ?? "")"
        viewsCount = itinraryDetail?.viewsCounter ?? 0
        likeCount = itinraryDetail?.likesCount ?? 0
        print(likeCount)
        likeLabel.text = "\(self.likeCount) Liked"
        viewCounterLabel.text = "\(viewsCount) Views"
        textView.text = itinraryDetail?.description?.stripOutHtml()
        favoriteBtn.setImage(itinraryDetail?.userLike == 1 ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        viewCounter(parameters: ["section_id": itinraryDetail?.id ?? 0, "section": "itinerary"])
        favoriteBtn.isUserInteractionEnabled = Helper.shared.disableWhenNotLogin()
    }
    
    func viewCounter(parameters: [String: Any]) {
        URLSession.shared.request(route: .viewCounter, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let viewCount):
                if viewCount.success == true {
                    guard var modelObject = DataManager.shared.itinraryModelObject else {
                        return
                    }
                    modelObject.viewsCounter = self.viewsCount + 1
                    DataManager.shared.itinraryModelObject = modelObject
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.addGradient()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableviewHeight.constant = self.tableView.contentSize.height
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        like(parameters: ["section_id": itinraryDetail?.id ?? 0, "section": "itinerary"])
    }
    
    func like(parameters: [String: Any]) {
        URLSession.shared.request(route: .likeApi, method: .post, showLoader: false, parameters: parameters, model: SuccessModel.self) { result in
            switch result {
            case .success(let like):
                self.favoriteBtn.setImage(like.message == "Liked" ? UIImage(named: "liked-red") : UIImage(named: "liked"), for: .normal)
                self.likeCount = like.message == "Liked" ? self.likeCount + 1 : self.likeCount - 1
                self.likeLabel.text = "\(self.likeCount) Liked"
                self.changeObject()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func changeObject(){
        guard var modelObject = DataManager.shared.itinraryModelObject else {
            return
        }
        modelObject.likesCount = self.likeCount
        modelObject.userLike = modelObject.userLike == 1 ? 0 : 1
        DataManager.shared.itinraryModelObject = modelObject
    }
}

extension ItinraryDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itinraryDetail?.activities.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItinraryDaysTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItinraryDaysTableViewCell") as! ItinraryDaysTableViewCell
        cell.activity = itinraryDetail?.activities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}
