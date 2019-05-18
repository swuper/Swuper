//
//  ThirdStepViewController.swift
//  Swuper
//
//  Created by 박주현 on 15/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class ThirdStepViewController: UIViewController {

    // MARK:- Properties
    let registerButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width*0.5-50,y: UIScreen.main.bounds.maxY - 80, width: 100,height: 40))
    
    // MARK:- IBOulet
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var selectImageButton: UIButton!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageView.image = UIImage(named: "beforeSelectItem")
        registerButton.setTitleColor(UIColor.blue, for: .normal)
        registerButton.setImage(UIImage(named: "register"), for: .normal)
        registerButton.addTarget(self, action: #selector(touchUpRegisterButton), for: .touchUpInside)
        self.view.addSubview(registerButton)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK:- Function
    @objc func touchUpRegisterButton() {
        print("aa")
    }
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
    @IBAction func openPhotoLibrary(_ sender: UIButton) {
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
        self.present(imagepicker, animated: true, completion: nil)
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

extension ThirdStepViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
