//
//  SecondViewController.swift
//  Swuper
//
//  Created by 박주현 on 15/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class SecondStepViewController: UIViewController {
    
    // MARK:- IBOulet
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var limitedPeopleTextField: UITextField!
    @IBOutlet var useTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    // MARK:- Function
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -120
    }
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    
    // MARK:- IBAction
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
