//
//  ItinraryDetailViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/8/23.
//

import UIKit

class ItinraryDetailViewController: BaseViewController {

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
    
    var itinraryDetail: ItinraryRow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back1
        placeLabel.text = "\(itinraryDetail?.fromDistricts.title ?? "") - \(itinraryDetail?.toDistricts.title ?? "")"
        textView.text = itinraryDetail?.description?.stripOutHtml()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
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
