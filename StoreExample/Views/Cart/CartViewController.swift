//
//  CartViewController.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import UIKit

class CartViewController: UITableViewController {

    var viewModel: CartViewModel?
    private var selectedProduct: CartItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        // If view nodel not set before set default view model
        if self.viewModel == nil {
            self.viewModel = CartViewModel()
        }
        // Fill data
        self.viewModel?.fillItems() { status in
            switch status {
            case .success:
                self.tableView.reloadData()
            case .error(let error):
                self.simpleAlert(title: "Error", message: "\(error)")
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.countOfItems(inSection: 0) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        if let product = self.viewModel?.item(at: indexPath) {
            cell.viewModel = ProductViewModel(product: product)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteHandlerFunction)
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
    }
    
    private func deleteHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        self.viewModel?.deleteItem(at: indexPath, completion: { status in
            self.tableView.reloadData()
        })
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Total Price = \(self.viewModel?.totalPrice() ?? "0" )" 
    }

}
