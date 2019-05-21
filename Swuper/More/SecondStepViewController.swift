//
//  SecondViewController.swift
//  Swuper
//
//  Created by 박주현 on 15/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class SecondStepViewController: UIViewController {
    
    //MARK:- Properties
    let datePicker = UIDatePicker()
    
    // MARK:- IBOulet
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var limitedPeopleTextField: UITextField!
    @IBOutlet var useTimeTextField: UITextField!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let locale = NSLocale(localeIdentifier: "ko_KO")
        datePicker.locale = locale as Locale
        showDatePicker()
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
    func showDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        if dateTextField.text == "" {
            datePicker.date = Date()
        }
        self.view.endEditing(true)
    }

    // MARK:- IBAction
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        if dateTextField.text == "" {
            datePicker.date = Date()
        }
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

// MARK:- Dalegate
extension SecondStepViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserInformation.shared.place = placeTextField.text
        UserInformation.shared.date = dateTextField.text
        UserInformation.shared.limitedPeople = limitedPeopleTextField.text
        UserInformation.shared.useTime = useTimeTextField.text
    }
}
