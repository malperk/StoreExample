//
//  ProductDetailViewController.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var addChart: UIButton!
    @IBOutlet weak var addFavorites: UIButton!

    var viewModel: (HasProduct & CartAddable & FavoritesAddable)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    private func setupView() {
        category.text = viewModel?.product.category
        name.text = viewModel?.product.name
        if viewModel?.product.oldPrice != nil {
            price.text = "\(viewModel!.product.price) was (\(viewModel!.product.oldPrice!))"
        } else {
            price.text = viewModel?.product.price.description
        }

        if viewModel!.product.stock > 0 {
            stock.text = self.viewModel?.product.stock.description
        } else {
            stock.text = "OUT OF STOCK"
            addChart.isHidden = true
        }

    }

    @IBAction func addFavoritesClick(_ sender: Any) {
        self.viewModel?.saveToFavorites(completion: { status in
            switch status {
            case .success:
                self.simpleAlert(title: "", message: "Item added to favorites.")
            case .error(let error):
                self.simpleAlert(title: "Error", message: "\(error)")
            }
        })
    }
    @IBAction func addChartClick(_ sender: Any) {
        self.viewModel?.saveToCart(completion: { status in
            switch status {
            case .success:
                self.simpleAlert(title: "", message: "Item added to cart.")
            case .error(let error):
                self.simpleAlert(title: "Error", message: "\(error)")
            }
        })
    }

}
