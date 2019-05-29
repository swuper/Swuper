import UIKit
import Kingfisher

class LikeListTableViewController: UIViewController {
    
    var itemResponse : [[String : Any]] = []
    let cell = "likecell"

    @IBOutlet weak var likeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.likeTableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let token = UserInformation.shared.token else { return }
        getAllItemRequest(token: token)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveAllItemNotification), name: DidRecieveAllItemNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveErrorNotification), name: DidRecieveErrorNotification, object: nil)
        DispatchQueue.main.async {
            self.likeTableView.reloadData()
        }
    }
    
    @objc func didRecieveAllItemNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] as? [[String:Any]] else { return }
        print("=================noti===================")
        //print(response)
        itemResponse.removeAll()
        for i in 0...response.count-1 {
            if (response[i]["like"] as? Int == 1) {
                itemResponse.append(response[i])
            }
        }
        print(itemResponse.count)
        print("=======like==========")
        print(itemResponse)
        DispatchQueue.main.async {
            self.likeTableView.reloadData()
        }
    }
    
    @objc func didRecieveErrorNotification(_ noti: Notification) {
        let alertController = UIAlertController(title: "알림", message: "다시 시도해 주세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: false, completion: nil)
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

extension LikeListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemResponse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = likeTableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? LikeListTableTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        guard let name = itemResponse[indexPath.row]["name"] as? String else { return UITableViewCell() }
        guard let imgURL = itemResponse[indexPath.row]["img"] as? String else { return UITableViewCell() }
        guard let id = itemResponse[indexPath.row]["id"] else { return UITableViewCell() }
        guard let userImgURL = itemResponse[indexPath.row]["memberImg"] as? String else { return UITableViewCell() }
        cell.likeButton.setImage(UIImage(named: "likeButton"), for: .normal)
        cell.itemImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgURL)!, cacheKey: imgURL))
        cell.userImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: userImgURL)!, cacheKey: userImgURL))
        cell.itemLabel.text = name
        cell.idLabel.text = String(id as! Int)
        return cell
    }
}

extension LikeListTableViewController: LikeCellDelegate {
    func likeCell(_ cell: LikeListTableTableViewCell, didTaplikeButton: UIButton) {
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        guard let id = cell.idLabel.text else { return }
        unlikeRequest(token: token, memberId: memberId, id: Int(id)!)
        getAllItemRequest(token: token)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveAllItemNotification), name: DidRecieveAllItemNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveErrorNotification), name: DidRecieveErrorNotification, object: nil)
        DispatchQueue.main.async {
            self.likeTableView.reloadData()
        }
    }
}
