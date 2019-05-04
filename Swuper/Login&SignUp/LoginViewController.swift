//
//  ViewController.swift
//  Swuper
//
//  Created by 박주현 on 10/04/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // IBOulet
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    
    // LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // IBAction
    @IBAction func TapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

// delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

