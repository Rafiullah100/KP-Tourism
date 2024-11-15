//
//  ProductViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 6/22/23.
//

import UIKit

class ProductViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewCell.cellReuseIdentifier())
        }
    }
    
    //pagination
    var totalCount = 0
    var currentPage = 1
    var limit = 5
    //explore
    var localProducts: [LocalProduct] = [LocalProduct]()
    var searchText: String?{
        didSet{
            reload()
        }
    }
    var cellType: CellType?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        cellType = .product
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("recalled")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if DataManager.shared.isProductDataLoaded == false {
            reload()
        }
        
        if let modelObject = DataManager.shared.productModelObject,
           let index = localProducts.firstIndex(where: { $0.id == modelObject.id }) {
            localProducts[index] = modelObject
            tableView.reloadData()
        }
    }
    
    func reload() {
        currentPage = 1
        localProducts.removeAll()
        loadData()
    }

    private func loadData(){
        fetchProduct(parameters: ["limit": limit, "page": currentPage, "user_id": UserDefaults.standard.userID ?? "", "search": searchText ?? ""])
    }

    func fetchProduct(parameters: [String: Any]) {
        dataTask = URLSession.shared.request(route: .fetchProduct, method: .post, parameters: parameters, model: ProductModel.self) { result in
            switch result {
            case .success(let product):
                self.localProducts.append(contentsOf: product.localProducts)
                self.totalCount = product.count
                self.localProducts.count == 0 ? self.tableView.setEmptyView("No Product Found!") : self.tableView.setEmptyView("")
                DataManager.shared.isProductDataLoaded = true
                self.tableView.reloadData()
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
            }
        }
    }
    
    func toggleWishlistStatus(for indexPath: IndexPath) {
        var product = localProducts[indexPath.row]
        product.isWished = product.isWished == 1 ? 0 : 1
        localProducts[indexPath.row] = product
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


extension ProductViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.localProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellType?.getClass().cellReuseIdentifier() ?? "") as! ProductTableViewCell
        cell.wishlistButtonTappedHandler = {
            self.toggleWishlistStatus(for: indexPath)
        }
        cell.configure(product: localProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if localProducts.count != totalCount && indexPath.row == localProducts.count - 1  {
            currentPage = currentPage + 1
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellType?.getHeight() ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoProductDetail(delegate: self, product: localProducts[indexPath.row], type: .list)
    }
}