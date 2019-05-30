import UIKit
import Kingfisher

class ProductListTableViewController: UIViewController {

    @IBOutlet var listTableView: UITableView!
    
    let cell = "item"
    let api = Api()
    var category: String?
    var arr: [String] = ["flower: A bouquet of shy love Roses / $8 for each bouquet", "ceramic: Hand-made ceramic Vessels / $22 for each vessels", "stationery: Come and see cute stationery! / up to $3"]
    var id:[Int] = []
    var image: [String] = []
    var name: [String] = []
    var text: [String] = []
    var price: [String] = []
    var sellImage:[String] = []
    var memberImage:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.separatorStyle = .none
        listTableView.delegate = self
        listTableView.dataSource = self
        self.title = category
        guard let token = UserInformation.shared.token else { return }
        guard let categoty = self.category else { return }
        Api.shared.token = token
        Api.shared.category = categoty
        DispatchQueue.main.async {
            Api.shared.ProductGetPage(viewcontroller: self, page: 0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            Api.shared.ProductGetPage(viewcontroller: self, page: 0)
            self.listTableView.reloadData()
        }
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


extension ProductListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return image.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as? ProductListTableViewCell else { return UITableViewCell() }
        cell.itemLabel.text = name[indexPath.row]+" - "+text[indexPath.row]+" - "+price[indexPath.row]
        cell.userImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: memberImage[indexPath.row])!, cacheKey: memberImage[indexPath.row]))
        cell.itemImage.kf.setImage(with: ImageResource(downloadURL: URL(string: image[indexPath.row])!, cacheKey: image[indexPath.row]))
        
        
        return cell
    }
}

extension ProductListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listTableView.deselectRow(at: indexPath, animated: false)
    }
}
