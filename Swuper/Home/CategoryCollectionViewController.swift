//
//  CategoryCollectionViewController.swift
//  Swuper
//
//  Created by 박주현 on 02/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class CategoryCollectionViewController: UIViewController {

    @IBOutlet var categorySegment: UISegmentedControl!
    
    let buttonBar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSegment()
        // Do any additional setup after loading the view.
    }
    

    func customSegment() {
        categorySegment.backgroundColor = .clear
        categorySegment.tintColor = .clear
        categorySegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        categorySegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.orange
            ], for: .selected)
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.orange
        view.addSubview(buttonBar)
        buttonBar.topAnchor.constraint(equalTo: categorySegment.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: categorySegment.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: categorySegment.widthAnchor, multiplier: 1 / CGFloat(categorySegment.numberOfSegments)).isActive = true
    }
    
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
