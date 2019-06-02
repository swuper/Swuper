import UIKit
import Kingfisher

class ProductListTableViewController: UIViewController {
    
    // MARK:- Properties
    let cell = "item"
    var category: String?
    var itemResponse: [[String : Any]] = []
    
    // MARK:- IBOulet
    @IBOutlet var listTableView: UITableView!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.separatorStyle = .none
        listTableView.delegate = self
        listTableView.dataSource = self
        self.title = category
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveCategoryItemNotification), name: DidRecieveCategoryItemNotification, object: nil)
        guard let token = UserInformation.shared.token else { return }
        guard let category = self.category else { return }
        getCategoryItemRequest(token: token, category: category)
    }
    
    // MARK:- Function
    @objc func didRecieveCategoryItemNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] as? [[String:Any]] else { return }
        self.itemResponse = response
        print("itemResponse")
        print(itemResponse)
        self.listTableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desVC = segue.destination as? ProductDetailViewController else { return }
        guard let cell = self.listTableView.indexPathForSelectedRow else { return }
        desVC.detailInfo = [itemResponse[cell.row]]
    }
}

// MARK:- DataSource
extension ProductListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemResponse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as? ProductListTableViewCell else { return UITableViewCell() }
        guard let imgURL = itemResponse[indexPath.row]["img"] as? String else { return UITableViewCell() }
        guard let userImgURL = itemResponse[indexPath.row]["memberImg"] as? String else { return UITableViewCell() }
        guard let itemName = itemResponse[indexPath.row]["name"] as? String else { return UITableViewCell() }
        guard let itemPrice = itemResponse[indexPath.row]["price"] as? String else { return UITableViewCell() }
        cell.itemLabel.text = itemName + " " + itemPrice
        cell.userImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: userImgURL)!, cacheKey: userImgURL))
        cell.itemImage.kf.setImage(with: ImageResource(downloadURL: URL(string: imgURL)!, cacheKey: imgURL))
        return cell
    }
}

// MARK:- Delegate
extension ProductListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listTableView.deselectRow(at: indexPath, animated: false)
    }
}
