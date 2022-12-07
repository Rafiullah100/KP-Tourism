//
//  ProfilePopUpViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/7/22.
//

import UIKit

class ProfilePopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: FollowerTableViewCell.cellReuseIdentifier())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfilePopUpViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowerTableViewCell = tableView.dequeueReusableCell(withIdentifier: FollowerTableViewCell.cellReuseIdentifier()) as! FollowerTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
