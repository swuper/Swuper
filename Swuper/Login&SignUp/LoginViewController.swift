//
//  ViewController.swift
//  Swuper
//
//  Created by 박주현 on 10/04/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func TapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

