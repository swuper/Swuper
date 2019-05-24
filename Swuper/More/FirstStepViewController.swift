//
//  FirstStepViewController.swift
//  Swuper
//
//  Created by 박주현 on 15/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class FirstStepViewController: UIViewController {
 
    //MARK:- Properties
    var pageControl = UIPageControl()
    let itemClassPicker = UIPickerView()
    let categoryPicker = UIPickerView()
    let itemClass: [String] = ["","상품", "클래스"]
    let itemCategory: [String] = ["","꽃", "문구류", "수제먹거리", "악세서리", "캔들,디퓨저", "공예품"]
    let classCateogry: [String] = ["", "음악", "스포츠", "교육"]
    
    // MARK:- IBOulet
    @IBOutlet var itemClassTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var kakaoTalkURLTextField: UITextField!

    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        itemClassPicker.delegate = self
        itemClassPicker.dataSource = self
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        itemClassTextField.inputView = itemClassPicker
        categoryTextField.inputView = categoryPicker
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

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}

// MARK:- Delegate
extension FirstStepViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let itemClassText = itemClassTextField.text {
            ItemInformation.firstPage.serviceCategory = itemClassText
        }
        if let categoryText = categoryTextField.text {
            ItemInformation.firstPage.productCategory = categoryText
        }
        if let titleText = titleTextField.text {
            ItemInformation.firstPage.name = titleText
        }
        if let priceText = priceTextField.text {
            ItemInformation.firstPage.price = priceText
        }
        if let linkText = kakaoTalkURLTextField.text {
            ItemInformation.firstPage.openChatHref = linkText
        }
        if(itemClassTextField.text == "" || categoryTextField.text == "" || titleTextField.text == "" || priceTextField.text == "" || kakaoTalkURLTextField.text == "") {
            ItemInformation.flag.firstFlag = false
        } else {
            ItemInformation.flag.firstFlag = true
        }

    }
}

extension FirstStepViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == itemClassPicker {
            itemClassTextField.text = itemClass[row]
        } else {
            if (itemClassTextField.text == "상품") {
                categoryTextField.text = itemCategory[row]
            } else if (itemClassTextField.text == "클래스") {
                categoryTextField.text = classCateogry[row]
            } else {
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == itemClassPicker {
            return itemClass[row]
        } else {
            if (itemClassTextField.text == "상품") {
                return itemCategory[row]
            } else if (itemClassTextField.text == "클래스") {
                return classCateogry[row]
            } else {
                return ("상품/클래스를 먼저 선택해주세요.")
            }
        }
    }
}

// MARK:- DataSource
extension FirstStepViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == itemClassPicker {
            return itemClass.count
        } else {
            if (itemClassTextField.text == "상품") {
                return itemCategory.count
            } else if (itemClassTextField.text == "클래스") {
                return classCateogry.count
            } else {
                return 1
            }
        }
    }
}
