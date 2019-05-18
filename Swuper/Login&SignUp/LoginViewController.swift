//
//  ViewController.swift
//  Swuper
//
//  Created by 박주현 on 10/04/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK:- IBOulet
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    
    // MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK:- Function
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    
    // MARK:- IBAction
    @IBAction func TapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

// MARK:- delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

