import UIKit

class ThirdStepViewController: UIViewController {

    // MARK:- Properties
    let registerButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width*0.5-50,y: UIScreen.main.bounds.maxY - 80, width: 100,height: 40))
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK:- IBOulet
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var explanationTextView: UITextView!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageView.image = UIImage(named: "beforeSelectItem")
        registerButton.setTitleColor(UIColor.blue, for: .normal)
        registerButton.setImage(UIImage(named: "register"), for: .normal)
        registerButton.addTarget(self, action: #selector(touchUpRegisterButton), for: .touchUpInside)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(registerButton)
        self.view.addSubview(activityIndicator)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(successUploadNotification), name: SuccessUploadNotification, object: nil)

    }
    
    // MARK:- Function
    @objc func touchUpRegisterButton() {
        activityIndicator.startAnimating()
        if (ItemInformation.flag.firstFlag == true && ItemInformation.flag.secondFlag == true) {
            guard let img = selectedImageView.image else { return }
            guard let info = explanationTextView.text else { return }
            if (img == nil || info == "") {
                // 정보를 모두 입력해주시오 alert
                print("정보를 모두 입력")
            } else {
                guard let memberId = UserInformation.shared.memberId else { return }
                guard let token = UserInformation.shared.token else { return }
                itemPost(memberId: memberId, category: (ItemInformation.firstPage.category)!, type: (ItemInformation.firstPage.type)!, name: (ItemInformation.firstPage.name)!, price: (ItemInformation.firstPage.price)!, openChatHref: (ItemInformation.firstPage.openChatHref)!, place: (ItemInformation.secondPage.place)!, startAt: (ItemInformation.secondPage.startAt)!, limitMemberNumber: (ItemInformation.secondPage.limitMemberNumber)!, spendTime: (ItemInformation.secondPage.spendTime)!, image: img, text: info, token: token)
            }
        } else {
            print("앞 내용 부족")
        }
    }
    
    
    @objc func successUploadNotification() {
        activityIndicator.stopAnimating()
        dismiss(animated: true, completion: nil)
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
}

// MARK:- Delegate
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
