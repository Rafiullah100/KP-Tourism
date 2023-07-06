//
//  BlogViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit

class BlogViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "BlogTableViewCell", bundle: nil), forCellReuseIdentifier: BlogTableViewCell.cellReuseIdentifier())
        }
    }
    
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    var blogs: [Blog] = [Blog]()
    var searchText: String?{
        didSet{
            blogs = []
            reloadData()
        }
    }
    var cellType: CellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        cellType = .blog
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let modelObject = DataManager.shared.blogModelObject,
           let index = blogs.firstIndex(where: { $0.id == modelObject.id }) {
            blogs[index] = modelObject
            tableView.reloadData()
        }
    }

    private func reloadData(){
        fetchBlog(parameters: ["limit": limit, "page": currentPage, "user_id": UserDefaults.standard.userID ?? "", "search": searchText ?? ""])
    }

    func fetchBlog(parameters: [String: Any]) {
        URLSession.shared.request(route: .fetchBlogs, method: .post, parameters: parameters, model: BlogsModel.self) { result in
            switch result {
            case .success(let blogModel):
                self.blogs.append(contentsOf: blogModel.blog)
                self.totalCount = blogModel.count ?? 0
                self.blogs.count == 0 ? self.tableView.setEmptyView("No Blog Found!") : self.tableView.setEmptyView("")
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func toggleWishlistStatus(for indexPath: IndexPath) {
        var blogObject = blogs[indexPath.row]
        blogObject.isWished = blogObject.isWished == 1 ? 0 : 1
        blogs[indexPath.row] = blogObject
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


extension BlogViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BlogTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! BlogTableViewCell
        cell.wishlistButtonTappedHandler = {
            self.toggleWishlistStatus(for: indexPath)
        }
        cell.blog = blogs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if blogs.count != totalCount && indexPath.row == blogs.count - 1  {
            currentPage = currentPage + 1
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoBlogDetail(delegate: self, blogDetail: blogs[indexPath.row], type: .list)
    }
}
