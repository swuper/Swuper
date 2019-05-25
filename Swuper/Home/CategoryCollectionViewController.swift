import UIKit

class CategoryCollectionViewController: UIViewController {

    // MARK:- IBOulet
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var categorySegment: UISegmentedControl!
    
    // MARk:- Properties
    let cell = "CategoryCell"
    let buttonBar = UIView()
    var categoryImage: [String] = ["earring", "flower", "macaron", "paper", "candle", "ceramic"]
    var categoryTitle: [String] = ["귀걸이", "꽃", "마카롱", "문구류", "캔들", "도자기"]
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: (249/255.0), green: (100/255.0), blue: (73/255.0), alpha: 1)]
        customSegment()
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let halfWidth = UIScreen.main.bounds.width / 2.0 - 10
        flowLayout.itemSize = CGSize(width: halfWidth, height: halfWidth * 1.2)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    // MARK:- Function
    func customSegment() {
        categorySegment.backgroundColor = .clear
        categorySegment.tintColor = .clear
        categorySegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        categorySegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor(red: (249/255.0), green: (100/255.0), blue: (73/255.0), alpha: 1)
            ], for: .selected)
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor(red: (249/255.0), green: (100/255.0), blue: (73/255.0), alpha: 1)
        view.addSubview(buttonBar)
        buttonBar.topAnchor.constraint(equalTo: categorySegment.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: categorySegment.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: categorySegment.widthAnchor, multiplier: 1 / CGFloat(categorySegment.numberOfSegments)).isActive = true
    }
    
    // MARK:-IBAction
    @IBAction func categorySegmentValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.categorySegment.frame.width / CGFloat(self.categorySegment.numberOfSegments)) * CGFloat(self.categorySegment.selectedSegmentIndex)
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

// MARK:- DataSource
extension CategoryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.categoryImageView.image = UIImage(named: categoryImage[indexPath.item])
        return cell
    }
}
