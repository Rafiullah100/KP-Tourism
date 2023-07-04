//
//  VisitViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit

class VisitViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "VisitKPTableViewCell", bundle: nil), forCellReuseIdentifier: VisitKPTableViewCell.cellReuseIdentifier())
        }
    }
    
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    var visit: [VisitKPRow] = [VisitKPRow]()
    var searchText: String?
    var cellType: CellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        cellType = .visitKP
        fetch()
    }

    func fetch() {
        URLSession.shared.request(route: .fetchVisitKp, method: .post, parameters: nil, model: VisitKPModel.self) { result in
            switch result {
            case .success(let visit):
                self.visit = visit.attractions.rows
                self.totalCount = visit.attractions.count
                self.totalCount == 0 ? self.tableView.setEmptyView("No Record Found!") : self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}


extension VisitViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VisitKPTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! VisitKPTableViewCell
        cell.visit = visit[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if visit[indexPath.row].isWizard == true {
            Switcher.gotoVisitKP(delegate: self)
        }
        else{
            Switcher.goToWizardVC(delegate: self, visitDetail:visit[indexPath.row])
        }
    }
}
