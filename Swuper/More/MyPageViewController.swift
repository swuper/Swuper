import UIKit

class MyPageViewController: UIViewController {
    
    // MARK:- Propertise
    let cell = "MyPageCell"
    var itemResponse : [[String : Any]] = []
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK:- IBOulet
    @IBOutlet var MyPageTableView: UITableView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MyPageTableView.separatorStyle = .none
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: (249/255.0), green: (100/255.0), blue: (73/255.0), alpha: 1)]
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveUserItemNotification), name: DidRecieveUserItemNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveErrorNotification), name: DidRecieveErrorNotification, object: nil)
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: UserInformation.shared.profileImg ?? "") else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(data: imageData)
            }
        }
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        userNameLabel.text = UserInformation.shared.username
        userEmailLabel.text = UserInformation.shared.email
        MyPageTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        activityIndicator.startAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveUserItemNotification), name: DidRecieveUserItemNotification, object: nil)
        userItemRequest(token: token, memberId: memberId)
        MyPageTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        DispatchQueue.main.async {
            self.MyPageTableView.reloadData()
        }
    }

    // MARK:- Function
    @objc func didRecieveUserItemNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] as? [[String:Any]] else { return }
        print("=================noti===================")
        itemResponse = response
        print(response)
        DispatchQueue.main.async {
            self.MyPageTableView.reloadData()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK:- DataSource
extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MyPageTableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        guard let name = itemResponse[indexPath.row]["name"] as? String else { return UITableViewCell() }
        guard let imgURL = itemResponse[indexPath.row]["img"] as? String else { return UITableViewCell() }
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: imgURL) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.itemImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        cell.itemTitleLabel.text = name
        return cell
    }
}


