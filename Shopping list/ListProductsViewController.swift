//
//  ListProductsViewController.swift
//  Shopping list
//
//  Created by Олег Рубан on 25.12.2021.
//

import UIKit

class ListProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProductDetailsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var productIndexToPass: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ProductDetailsController,
           let index = productIndexToPass {
            
            controller.delegate = self
            controller.productIndex = index
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductStorage.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell") as? ProductsCell {
            cell.update(product: ProductStorage.products[indexPath.row])
            return cell
        }
        
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productIndexToPass = indexPath.row
        performSegue(withIdentifier: "showProduct", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ProductStorage.products.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func productDetailsControllerWillDismiss() {
        tableView.reloadData()
    }
}
