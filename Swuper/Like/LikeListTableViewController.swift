import UIKit
import Kingfisher

class LikeListTableViewController: UIViewController {
    
    // Properties
    var itemResponse : [[String : Any]] = []
    let cell = "likecell"
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var refreshControl = UIRefreshControl()
    
    // IBOulet
    @IBOutlet weak var likeTableView: UITableView!
    
    // LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLikeItemNotification), name: DidRecieveLikeItemNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveErrorNotification), name: DidRecieveErrorNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unlikeNotification), name: UnlikeNotification, object: nil)
        self.likeTableView.separatorStyle = .none
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        likeTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard let token = UserInformation.shared.token else { return }
        self.activityIndicator.startAnimating()
        likeItemRequest(token: token)
        
        DispatchQueue.main.async {
            self.likeTableView.reloadData()
        }
    }
    
    // Function
    @objc func didRecieveLikeItemNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] as? [[String:Any]] else { return }
        print("=================noti===================")
        //print(response)
        itemResponse = response
        print(itemResponse.count)
        print("=======like==========")
        print(itemResponse)
        activityIndicator.stopAnimating()
        self.likeTableView.reloadData()
    }
    
    @objc func didRecieveErrorNotification(_ noti: Notification) {
        activityIndicator.stopAnimating()
        let alertController = UIAlertController(title: "알림", message: "다시 시도해 주세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: false, completion: nil)
    }
    
    @objc func refresh(){
        guard let token = UserInformation.shared.token else { return }
        likeItemRequest(token: token)
        self.likeTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @objc func unlikeNotification() {
        guard let token = UserInformation.shared.token else { return }
        likeItemRequest(token: token)
        self.likeTableView.reloadData()
        self.refreshControl.endRefreshing()

    }
    
     // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desVC = segue.destination as? ProductDetailViewController else { return }
        guard let cell = self.likeTableView.indexPathForSelectedRow else { return }
        desVC.detailInfo = [itemResponse[cell.row]]
    }
}

// DataSource
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


// MARK:- Delegate
extension LikeListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.likeTableView.deselectRow(at: indexPath, animated: false)
    }
}

extension LikeListTableViewController: LikeCellDelegate {
    func likeCell(_ cell: LikeListTableTableViewCell, didTaplikeButton: UIButton) {
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        guard let id = cell.idLabel.text else { return }
        unlikeRequest(token: token, memberId: memberId, id: Int(id)!)
        likeItemRequest(token: token)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLikeItemNotification), name: DidRecieveLikeItemNotification, object: nil)
        DispatchQueue.main.async {
            self.likeTableView.reloadData()
        }
    }
}
