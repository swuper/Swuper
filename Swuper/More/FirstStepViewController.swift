//
//  FirstStepViewController.swift
//  Swuper
//
//  Created by 박주현 on 15/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit
import iOSDropDown

class FirstStepViewController: UIViewController {
 
    //MARK:- Properties
    var pageControl = UIPageControl()

    // MARK:- IBOulet
    @IBOutlet var itemClassDropDown: DropDown!
    @IBOutlet var categoryDropDown: DropDown!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var kakaoTalkURLTextField: UITextField!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        itemClassDropDown.optionArray = ["상품", "클래스"]
        categoryDropDown.optionArray = ["꽃", "문구류", "수제먹거리", "악세서리", "캔들,디퓨저", "공예품"]
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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

// MARK:- Delegate
extension FirstStepViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
