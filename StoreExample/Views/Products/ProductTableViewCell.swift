//
//  ProductTableViewCell.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!

    var viewModel: HasProduct? {
        didSet {
            self.name.text = self.viewModel?.product.name
            self.price.text = self.viewModel?.product.price.description
        }
    }

}
