//
//  ProductDetailsController.swift
//  Shopping list
//
//  Created by Олег Рубан on 30.12.2021.
//

import UIKit

protocol ProductDetailsControllerDelegate {
    func productDetailsControllerWillDismiss()
}

class ProductDetailsController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTotalLabel: UILabel!
    
    var productIndex: Int!
    var delegate: ProductDetailsControllerDelegate?
    
    @IBAction func addCountButton(_ sender: Any) {
        var product = ProductStorage.products[productIndex]
        product.numbers += 1
        ProductStorage.products[productIndex] = product
        
        update()
    }
    
    @IBAction func removeCountButton(_ sender: Any) {
        var product = ProductStorage.products[productIndex]
        product.numbers = max(1, product.numbers - 1)
        ProductStorage.products[productIndex] = product
        
        update()
    }
    
    @IBAction func addPriceButton(_ sender: Any) {
        var product = ProductStorage.products[productIndex]
        product.price += 1
        ProductStorage.products[productIndex] = product
        
        update()
    }
    
    @IBAction func removePriceButton(_ sender: Any) {
        var product = ProductStorage.products[productIndex]
        product.price = max(1, product.price - 1)
        ProductStorage.products[productIndex] = product
        
        update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.productDetailsControllerWillDismiss()
    }
    
    func update() {
        let product = ProductStorage.products[productIndex]
        
        imageView.image = product.image
        productNameLabel.text = product.name
        productCountLabel.text = "Количество: \(product.numbers)"
        productPriceLabel.text = "Цена: \(product.price)"
        productTotalLabel.text = "Стоимость: \(product.numbers * product.price)"
    }
}
