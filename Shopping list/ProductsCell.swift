//
//  ProductsCell.swift
//  Shopping list
//
//  Created by Олег Рубан on 25.12.2021.
//

import UIKit

class ProductsCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var imageTable: UIImageView!
    
    
    func update(product: Product) {
        nameLabel.text = product.name
        numbersLabel.text = "Количество \(product.numbers)"
        priceLabel.text = "Цена \(product.price)"
        totalLabel.text = "Стоимость \(product.numbers * product.price)"
        imageTable.image = product.image
    }
}
