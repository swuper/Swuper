import UIKit
import Kingfisher

class MyPageViewController: UIViewController {
    
    // MARK:- Propertise
    let cell = "MyPageCell"
    var itemResponse : [[String : Any]] = []
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var count = 0
    private var refreshControl = UIRefreshControl()
    
    // MARK:- IBOulet
    @IBOutlet var myPageTableView: UITableView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveUserItemNotification), name: DidRecieveUserItemNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveErrorNotification), name: DidRecieveErrorNotification, object: nil)
        self.myPageTableView.separatorStyle = .none
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: (249/255.0), green: (100/255.0), blue: (73/255.0), alpha: 1)]
        guard let imgURL = UserInformation.shared.profileImg else { return }
        self.userImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgURL)!, cacheKey: imgURL))
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        myPageTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        userNameLabel.text = UserInformation.shared.username
        userEmailLabel.text = UserInformation.shared.email
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        activityIndicator.startAnimating()
        userItemRequest(token: token, memberId: memberId)
        DispatchQueue.main.async {
            self.myPageTableView.reloadData()
        }
    }

    // MARK:- Function
    @objc func didRecieveUserItemNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] as? [[String:Any]] else { return }
        print("=================noti===================")
        itemResponse = response
        print(response)
        DispatchQueue.main.async {
            self.myPageTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc func didRecieveErrorNotification(_ noti: Notification) {
        let alertController = UIAlertController(title: "알림", message: "데이터를 가져오지 못하였습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: false, completion: nil)
        activityIndicator.stopAnimating()
    }
    
    @objc func refresh() {
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        userItemRequest(token: token, memberId: memberId)
        self.myPageTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desVC = segue.destination as? ProductDetailViewController else { return }
        guard let selectedRow = self.myPageTableView.indexPathForSelectedRow else { return }
        desVC.detailInfo = [itemResponse[selectedRow.row]]
    }
    
}

// MARK:- DataSource
extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myPageTableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        guard let name = itemResponse[indexPath.row]["name"] as? String else { return UITableViewCell() }
        guard let imgURL = itemResponse[indexPath.row]["img"] as? String else { return UITableViewCell() }
        cell.itemImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgURL)!, cacheKey: imgURL))
        cell.itemTitleLabel.text = name
        return cell
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.myPageTableView.deselectRow(at: indexPath, animated: false)
    }
}
