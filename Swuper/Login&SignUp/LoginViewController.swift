import UIKit

class LoginViewController: UIViewController {
    
    // MARK:- Properties
    var response: Any?

    // MARK:- IBOulet
    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    
    // MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordTextField.isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        userItemRequest(token: token, memberId: memberId)
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(didrecieveLoginTokenNotification), name: DidRecieveLoginTokenNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveExeptionNotification), name: DidRecieveExceptionNotification, object: nil)
    }
    
    
    // MARK:- Function
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -100
    }
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    @objc func didrecieveLoginTokenNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] else { return }
        print("=============response===========")
        print(response)
        print("=============================")
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") else { return }
        VC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        present(VC, animated: true, completion: nil)
    }
    @objc func didRecieveExeptionNotification(_ noit: Notification) {
        showAlertController(style: UIAlertController.Style.alert)
    }
    func showAlertController(style: UIAlertController.Style) {
        let alertController = UIAlertController(title: "경고", message: "로그인 정보가 일치하지 않습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: false, completion: nil)
    }
    
    // MARK:- IBAction
    @IBAction func TapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func touchUpLoginButton(_ sender: UIButton) {
        guard let id = IDTextField.text else { return }
        guard let password = PasswordTextField.text else { return }
        LoginPost(id: id, password: password)
    }
}

// MARK:- delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

