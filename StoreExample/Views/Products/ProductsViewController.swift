//
//  ProductsViewController.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import UIKit

class ProductsViewController: UITableViewController {

    var viewModel: HasProductListWithSection?
    private var selectedProduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        // If view nodel not set before set default view model
        if self.viewModel == nil {
            self.viewModel = ProductListViewModel()
        }
        // Fill data
        self.viewModel?.fillProducts() { status in
            switch status {
            case .success:
                self.tableView.reloadData()
            case .error(let error):
                self.simpleAlert(title: "Error", message: "\(error)")
            }

        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.countOfSections() ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.countOfProducts(inSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        if let product = self.viewModel?.product(at: indexPath) {
            cell.viewModel = ProductViewModel(product: product)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel?.categoryName(inSection: section) ?? ""
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? ProductTableViewCell else {
            return
        }
        guard let product = cell.viewModel?.product else {
            return
        }
        self.selectedProduct = product
        self.performSegue(withIdentifier: "goDetail", sender: nil)
    }
    // MARK: - Assign data to detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail" {
            guard let viewController = segue.destination as? ProductDetailViewController else {
                return
            }
            viewController.viewModel = ProductViewModel(product: self.selectedProduct!)
        }
    }
}
