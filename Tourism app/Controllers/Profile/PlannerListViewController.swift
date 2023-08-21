//
//  PlannerListViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 8/11/23.
//

import UIKit

class PlannerTableViewCell: UITableViewCell {
//    var experienceID: Int?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("selected")
    }
    
    var tourPlane: UserTourPlanModel?{
        didSet{
        }
    }
    
}


class PlannerListViewController: BaseViewController {
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var userTourPlans: [UserTourPlanModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.addBottomShadow()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTourList), name: NSNotification.Name(rawValue: Constants.tourPlan), object: nil)
    }
    
    func loadData(){
        fetchTourList()
    }
    
    @objc func fetchTourList() {
        dataTask = URLSession.shared.request(route: .tourList, method: .post, showLoader: true, parameters: nil, model: TourListModel.self) { result in
            switch result {
            case .success(let model):
                self.userTourPlans = model.userTourPlans ?? []
                self.userTourPlans?.count == 0 ? self.tableView.setEmptyView("No tour plane found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }

    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PlannerListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTourPlans?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! PlannerTableViewCell
        cell.titleLabel.text = "\(userTourPlans?[indexPath.row].district?.title ?? "") - \(userTourPlans?[indexPath.row].attraction?.title ?? "")"
        cell.dateLabel.text = "Created: \(Helper.shared.dateFormate(dateString: userTourPlans?[indexPath.row].createdAt ?? ""))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let plan = userTourPlans?[indexPath.row] else { return }
        Switcher.gotoTourPlannerDetailVC(delegate: self, tourPlan: plan)
    }
}



