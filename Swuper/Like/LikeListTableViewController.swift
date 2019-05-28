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
    }
    
    @objc func didRecieveAllItemNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] as? [[String:Any]] else { return }
        print("=================noti===================")
        //print(response)
        for i in 0...response.count-1 {
            if (response[i]["like"] as? Int == 1) {
                itemResponse.append(response[i])
            }
        }
        print(itemResponse.count)
        print("=======like==========")
        print(itemResponse)
        likeTableView.reloadData()
    }
    
    @objc func touchUpLikeButton(_ sender: Any)
    {
        // 좋아요 버튼 눌렀을때 action
        print("likebutton")
        likeTableView.reloadData()
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
        guard let name = itemResponse[indexPath.row]["name"] as? String else { return UITableViewCell() }
        guard let imgURL = itemResponse[indexPath.row]["img"] as? String else { return UITableViewCell() }
        guard let userImgURL = itemResponse[indexPath.row]["memberImg"] as? String else { return UITableViewCell() }
        cell.itemImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgURL)!, cacheKey: imgURL))
        cell.userImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: userImgURL)!, cacheKey: userImgURL))
        cell.itemLabel.text = name
        cell.likeButton.addTarget(self, action: #selector(touchUpLikeButton(_:)), for: .touchUpInside)

        return cell
    }

}
