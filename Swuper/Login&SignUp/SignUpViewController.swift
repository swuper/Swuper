import UIKit

class SignUpViewController: UIViewController {

    // MARK:- IBOulet
    @IBOutlet var EmailAdressTextField: UITextField!
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    @IBOutlet var selectedImageView: UIImageView!
    
    // MARK:- Properties
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageView.image = UIImage(named: "user")
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        PasswordField.isSecureTextEntry = true
        ConfirmPasswordTextField.isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        //activityIndicator.activityIndicatorView.Style = UIActivityIndicatorView.Style.gray
    }
    
    // MARK:- Function
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -50
    }
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK:- IBAction
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
            
            guard var img = selectedImageView.image else { return }
            if (img == nil) {
                img = UIImage(named: "user")!
            }

            signUpRequest(emailAdress: EmailAdressTextField.text ?? "", name: IDTextField.text ?? "", password: PasswordField.text ?? "", image: img)

            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activityIndicator.stopAnimating()
            dismiss(animated: true, completion: nil)
        } else {
            // 비밀번호가 일치하지 않다는 alert 띄우기
            let alertController = UIAlertController(title: "경고", message: "비밀번호가 일치하지 않습니다", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: false, completion: nil)
        }
    }
    
}

// MARK:- delegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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


