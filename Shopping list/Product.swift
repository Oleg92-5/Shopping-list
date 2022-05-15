//
//  Products.swift
//  Shopping list
//
//  Created by Олег Рубан on 25.12.2021.
//

import Foundation
import UIKit

struct Product: Codable {
    var name: String
    var numbers: Int
    var price: Int
    
    var lowercasedName: String {
        return name.lowercased()
            .replacingOccurrences(of: "ё", with: "е")
    }
    
    var image: UIImage? {
        if lowercasedName == "яблоко" || lowercasedName == "яблоки" {
            return UIImage(named: "apple")
        } else if lowercasedName == "банан" || lowercasedName == "бананы" {
            return UIImage(named: "banana")

        }  else if lowercasedName == "апельсин" || lowercasedName == "апельсины" {
            return UIImage(named: "orange")
            
        } else if lowercasedName == "яйцо" || lowercasedName == "яйца" {
            return UIImage(named: "egg")
            
        } else if lowercasedName == "рыба" || lowercasedName == "креветки" || lowercasedName == "кальмары" || lowercasedName == "форель"  || lowercasedName == "семга" {
            return UIImage(named: "fish")
            
        } else if lowercasedName == "хлеб" {
            return UIImage(named: "bread")
            
        } else if lowercasedName == "конфеты" || lowercasedName == "сладости" {
            return UIImage(named: "candy")
            
        } else if lowercasedName == "перец" || lowercasedName == "перец красный" || lowercasedName == "перец желтый" || lowercasedName == "перец зеленый" {
            return UIImage(named: "pepper")
            
        } else if lowercasedName == "огурец" || lowercasedName == "огурцы" {
            return UIImage(named: "cucumber")
            
        } else if lowercasedName == "томат" || lowercasedName == "томаты" || lowercasedName == "помидоры"  || lowercasedName == "помидор" {
            return UIImage(named: "tomato")
            
        } else if lowercasedName == "курица" {
            return UIImage(named: "chicken")
            
        } else if lowercasedName == "говядина" || lowercasedName == "мясо" {
            return UIImage(named: "beef")
            
        } else if lowercasedName == "свинина" {
            return UIImage(named: "pork")
            
        } else {
            return UIImage(named: "cart")
        }
    }
}

struct ProductStorage {
    static var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var fileUrl: URL {
        return documentsUrl.appendingPathComponent("products.json")
    }
    
    static var products = saved {
        didSet {
            save(products: products)
        }
    }
    
    static var saved: [Product] {
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            print("Products file doesn't exist")
            return []
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            
            print("Loaded \(products.count) products")
            return products
        } catch let error {
            print("Error loading products: \(error.localizedDescription)")
        }
        
        return []
    }
    
    static func save(products: [Product]) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(products)
            try data.write(to: fileUrl)
            
            print("Products saved to file")
        } catch let error {
            print("Error saving products: \(error.localizedDescription)")
        }
    }
}

struct Validator {
    func isOnlyNumbers(text: String) -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: text))
    }
}


