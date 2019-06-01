import Foundation
import UIKit

protocol LikeCellDelegate: class {
    func likeCell(_ cell: LikeListTableTableViewCell, didTaplikeButton: UIButton) 
}

protocol LikeUnLikeButtonDelegate: class {
    func likeUnlikeButton(_ cell: ItemImageTableViewCell, didTaplikeButton: UIButton)
}
