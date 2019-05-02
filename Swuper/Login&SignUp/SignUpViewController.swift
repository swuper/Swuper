//
//  SignUpViewController.swift
//  Swuper
//
//  Created by 박주현 on 29/04/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var EmailAdressTextField: UITextField!
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func touchUpCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func touchUpSignUpButton(_ sender: UIButton) {
        
    }
    
}
