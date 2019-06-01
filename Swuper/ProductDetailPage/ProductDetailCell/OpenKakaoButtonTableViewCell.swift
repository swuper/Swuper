import UIKit

class OpenKakaoButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var openKakaoButton: UIButton!
    
    override func awakeFromNib() {
        DispatchQueue.main.async {
            self.openKakaoButton.addTarget(self, action: #selector(self.touchUpOpenkakaoButton(_:)), for: .touchUpInside)
        }
        super.awakeFromNib()
    }

    @objc func touchUpOpenkakaoButton(_ sender: UIButton) {
        UIApplication.shared.open (NSURL(string:"https://open.kakao.com/o/swL6xUnb")! as URL)
    }
}
