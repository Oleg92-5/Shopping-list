//
//  ViewController.swift
//  Shopping list
//
//  Created by Олег Рубан on 25.12.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numbersField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var viewCenterY: NSLayoutConstraint!
    
    private let keyboardOffset: CGFloat = 106.0
    
    var containerOffset: CGFloat {
        return viewCenterY.constant.magnitude
    }
    
    var containerFrame: CGRect {
        return containerView.frame.offsetBy(dx: 0.0, dy: containerOffset)
    }
    //
    
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        numbersField.delegate = self
        priceField.delegate = self
        
        addButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribe()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        NotificationCenter.default.removeObserver(self)
    }

    
    func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func validateInput() {
        addButton.isEnabled = !nameField.isEmpty && !numbersField.isEmpty && !priceField.isEmpty
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let sourceString = (textField.text ?? "") as NSString
        let resultString = sourceString.replacingCharacters(in: range, with: string)
        
        if textField == priceField || textField == numbersField {
            if !validator.isOnlyNumbers(text: resultString) {
                return false
            }
        }
        
        textField.text = resultString
        
        validateInput()
        
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = nil
        validateInput()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        let product = Product(name: nameField.text!,
                              numbers: Int(numbersField.text!) ?? 0,
                              price: Int(priceField.text!) ?? 0)
                              
        ProductStorage.products.append(product)
        
        nameField.text = nil
        numbersField.text = nil
        priceField.text = nil
        
        view.endEditing(true)
        
        validateInput()
    }

    @objc func keyboardShowHide(_ payload: Notification) {
        if let keyboardFrame = payload.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let animDuration = payload.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
            
            let overlappedFrame = containerFrame.intersection(keyboardFrame)
            let overlappedHeight = overlappedFrame.height
            let targetOffset = overlappedHeight + keyboardOffset
            
            viewCenterY.constant = -targetOffset
            UIView.animate(withDuration: animDuration, delay: 0.1, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
