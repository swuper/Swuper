import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK:- Properties
    let itemImageSection = 0
    let itemTitleSection = 1
    let itemInfoSection = 2
    let itemDetailInfoSection = 3
    let OpenKakaoButtonSection = 4

    // MARK:- IBOulet
    @IBOutlet weak var detailTableView: UITableView!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.separatorStyle = .none

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ProductDetailView")
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
            cell.itemImageView.image = UIImage(named: "swuper")
            return cell
        } else if indexPath.section == itemTitleSection {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "titlecell", for: indexPath) as? ItemTitleTableViewCell else { return UITableViewCell() }
            cell.userNameLabel.text = "by 쭈"
            return cell
        } else if indexPath.section == itemInfoSection {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "iteminfocell", for: indexPath) as? ItemInfoTableViewCell else { return UITableViewCell() }
            cell.placeLabel.text = "50주년 기념관 505호"
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
