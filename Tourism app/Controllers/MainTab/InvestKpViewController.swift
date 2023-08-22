//
//  InvestKpViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit

class InvestKpViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "InvestmentTableViewCell", bundle: nil), forCellReuseIdentifier: InvestmentTableViewCell.cellReuseIdentifier())
        }
    }
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    var investment: [InvestmentRow] = [InvestmentRow]()
    var searchText: String?{
        didSet{
            reload()
        }
    }
    var cellType: CellType?
    var isDataLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        cellType = .investment
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isDataLoaded == false {
            reload()
        }
    }
    
    func reload() {
        currentPage = 1
        investment.removeAll()
        loadData()
    }
    
    private func loadData(){
        fetchInvestment(parameters: ["limit": limit, "page": currentPage, "search": searchText ?? ""])
    }
    
    func fetchInvestment(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .fetchInvestment, method: .post, parameters: parameters, model: InvestmentModel.self) { result in
            switch result {
            case .success(let investment):
                self.investment.append(contentsOf: investment.investments?.rows ?? [])
                self.totalCount = investment.investments?.count ?? 0
                self.investment.count == 0 ? self.tableView.setEmptyView("No investment in KP Found!") : self.tableView.setEmptyView("")
                self.isDataLoaded = true
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
}


extension InvestKpViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.investment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InvestmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! InvestmentTableViewCell
        cell.investment = investment[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if investment.count != totalCount && indexPath.row == investment.count - 1  {
            currentPage = currentPage + 1
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = investment[indexPath.row].fileURL else {
            return
        }
        Switcher.gotoPDFViewer(delegate: self, url: urlString)
    }
}
