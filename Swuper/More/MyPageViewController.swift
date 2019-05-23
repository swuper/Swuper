//
//  MyPageViewController.swift
//  Swuper
//
//  Created by 박주현 on 02/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet var MyPageTableView: UITableView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = UserInformation.shared.username
        userEmailLabel.text = UserInformation.shared.email
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: UserInformation.shared.profileImg ?? "") else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(data: imageData)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        MyPageTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        MyPageTableView.reloadData()
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


