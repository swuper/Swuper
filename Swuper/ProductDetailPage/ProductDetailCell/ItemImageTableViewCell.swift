import UIKit

class ItemImageTableViewCell: UITableViewCell {
    
    weak var delegate: LikeUnLikeButtonDelegate?

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var itemId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.likeButton.addTarget(self, action: #selector(self.touchUpLikeButton(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLikeErrorNotification), name: DidRecieveLikeErrorNotification, object: nil)
    }
    
    
    @objc func didRecieveLikeErrorNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["Error"] else { return }
        print("에러에러에러에러")
        if likeButton.imageView?.image == UIImage(named: "likeButton") {
            likeButton.setImage(UIImage(named: "emptylikeButton"), for: .normal)
            print("좋아요취소")
        } else {
            likeButton.setImage(UIImage(named: "likeButton"), for: .normal)
            print("좋아요")
        }
    }
    
    @objc func touchUpLikeButton(_ sender: UIButton) {
        delegate?.likeUnlikeButton(self, didTaplikeButton: sender)
        
        if likeButton.imageView?.image == UIImage(named: "likeButton") {
            likeButton.setImage(UIImage(named: "emptylikeButton"), for: .normal)
            print("좋아요취소")
        } else {
            likeButton.setImage(UIImage(named: "likeButton"), for: .normal)
            print("좋아요")
        }
    }
}
