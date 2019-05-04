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
    @IBOutlet var selectedImageView: UIImageView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        //activityIndicator.activityIndicatorView.Style = UIActivityIndicatorView.Style.gray
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func TapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func touchUpCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
        self.present(imagepicker, animated: true, completion: nil)
    }
    
    @IBAction func touchUpSignUpButton(_ sender: UIButton) {
        if (EmailAdressTextField.text == "" || IDTextField.text == "" || PasswordField.text == "" || ConfirmPasswordTextField.text == "") {
            let alertController = UIAlertController(title: "알림", message: "빈칸을 모두 작성해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: false, completion: nil)
        }
        
        
        if (PasswordField.text == ConfirmPasswordTextField.text) {
            // 인코딩
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            activityIndicator.startAnimating()
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
//            let content = LoginEncodingModel(emailAdress: self.EmailAdressTextField.text, password: self.PasswordField.text, name: self.IDTextField.text)
//            let jsonData = try? encoder.encode(content)
//            if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
////                {
////                    "emailAdress" : "aaa",
////                    "name" : "vvv",
////                    "password" : "ccc"
////                }
//            }
            guard let img = UIImage(named: "user") else { return }
            post(emailAdress: EmailAdressTextField.text ?? "", name: IDTextField.text ?? "", password: PasswordField.text ?? "", image: selectedImageView.image ?? img)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activityIndicator.stopAnimating()
        } else {
            // 비밀번호가 일치하지 않다는 alert 띄우기
            let alertController = UIAlertController(title: "경고", message: "비밀번호가 일치하지 않습니다", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: false, completion: nil)
        }
    }
    
}


extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageView.image = img
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
