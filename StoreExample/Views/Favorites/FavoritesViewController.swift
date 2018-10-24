//
//  FavoritesViewController.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UITableViewController {

    var viewModel: FavoritesViewModel?
    private var selectedProduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        // If view nodel not set before set default view model
        if self.viewModel == nil {
            self.viewModel = FavoritesViewModel()
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.fillFavorites() { status in
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.countOfFavorites(inSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)

        if let favorite = self.viewModel?.favorite(at: indexPath) {
            cell.textLabel?.text = favorite.name
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
            switch status {
            case .success:
                self.tableView.reloadData()
            case .error(let error):
                self.simpleAlert(title: "Error", message: "\(error)")
            }
        })
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = self.viewModel?.product(at: indexPath) else {
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
