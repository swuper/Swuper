import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    // MARK:- Properties
    let itemImageSection = 0
    let itemTitleSection = 1
    let itemInfoSection = 2
    let itemDetailInfoSection = 3
    let OpenKakaoButtonSection = 4
    var detailInfo: [[String : Any]] = []

    // MARK:- IBOulet
    @IBOutlet weak var detailTableView: UITableView!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        print("ProductDetailView")
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveErrorNotification(_:)), name: DidRecieveErrorNotification, object: nil)
    }
    
    // MARK:- Function
    @objc func didRecieveErrorNotification(_ noti: Notification) {
        let alertController = UIAlertController(title: "알림", message: "다시 시도해 주세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: false, completion: nil)
    }
}

// MARK:- Delegate
extension ProductDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == itemImageSection {
            return 1
        } else if section == itemTitleSection {
            return 1
        }
        else if section == itemInfoSection {
            return 1
        } else if section == itemDetailInfoSection {
            return 1
        } else if section == OpenKakaoButtonSection {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == itemImageSection {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as? ItemImageTableViewCell else { return UITableViewCell() }
            guard let imgURL = detailInfo[indexPath.row]["img"] as? String else { return UITableViewCell() }
            guard let like = detailInfo[indexPath.row]["like"] as? Int else { return UITableViewCell() }
            guard let itemId = detailInfo[indexPath.row]["id"] as? Int else { return UITableViewCell() }
            cell.itemImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgURL)!, cacheKey: imgURL))
            cell.itemId.text = String(itemId)
            if like == 1 {
                cell.likeButton.setImage(UIImage(named: "likeButton"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(named: "emptylikeButton"), for: .normal)
            }
            cell.delegate = self
            return cell
        } else if indexPath.section == itemTitleSection {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "titlecell", for: indexPath) as? ItemTitleTableViewCell else { return UITableViewCell() }
            guard let username = UserInformation.shared.username else { return UITableViewCell() }
            guard let itemTitle = detailInfo[indexPath.row]["name"] as? String else { return UITableViewCell() }
            guard let price = detailInfo[indexPath.row]["price"] as? String else { return UITableViewCell() }
            cell.userNameLabel.text = "by " + username
            cell.itemTitleLabel.text = itemTitle
            cell.priceLabel.text = price
            return cell
        } else if indexPath.section == itemInfoSection {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "iteminfocell", for: indexPath) as? ItemInfoTableViewCell else { return UITableViewCell() }
            guard let place = detailInfo[indexPath.row]["place"] as? String else { return UITableViewCell() }
            guard let startAt = detailInfo[indexPath.row]["startAt"] as? String else { return UITableViewCell() }
            guard let spendTime = detailInfo[indexPath.row]["spendTime"] as? String else { return UITableViewCell() }
            guard let limitPeople = detailInfo[indexPath.row]["limitMemberNumber"] as? Int else { return UITableViewCell() }
            cell.placeLabel.text = place
            cell.dateLabel.text = startAt
            cell.useTimeLabel.text = spendTime
            cell.limitedPeopleLabel.text = String(limitPeople)
            return cell
        } else if indexPath.section == itemDetailInfoSection {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailinfocell", for: indexPath) as? ItemDetailInfoTableViewCell else { return UITableViewCell()}
            cell.detailInfoLabel.text = "아아아아아아ㅏ아아아ㅏ아아아아ㅏ아아아아ㅏ아아아아ㅏ아아아ㅏ아아아아아아아ㅏ아아아아ㅏ아아아아ㅏ아아아아아"
            return cell
        } else if indexPath.section == OpenKakaoButtonSection {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "openchatcell", for: indexPath) as? OpenKakaoButtonTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}


extension ProductDetailViewController: LikeUnLikeButtonDelegate {
    func likeUnlikeButton(_ cell: ItemImageTableViewCell, didTaplikeButton: UIButton) {
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        guard let id = cell.itemId.text else { return }
        guard let button = cell.likeButton.imageView?.image else { return }
        if button == UIImage(named: "likeButton") {
            // 좋아요 취소
            unlikeRequest(token: token, memberId: memberId, id: Int(id)!)
            print("nono")
        } else {
            // 좋아요
            likeRequest(token: token, memberId: memberId, id: Int(id)!)
            print("yesyes")
        }
    }
}
