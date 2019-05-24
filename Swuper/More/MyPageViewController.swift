//
//  MyPageViewController.swift
//  Swuper
//
//  Created by 박주현 on 02/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK:- Propertise
    let cell = "MyPageCell"
    var res : [[String : Any]] = []
    
    // MARK:- IBOulet
    @IBOutlet var MyPageTableView: UITableView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = UserInformation.shared.username
        userEmailLabel.text = UserInformation.shared.email
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveUserItemNotification), name: DidRecieveUserItemNotification, object: nil)
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: UserInformation.shared.profileImg ?? "") else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(data: imageData)
            }
        }
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        userItemRequest(token: token, memberId: memberId)
        MyPageTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveUserItemNotification), name: DidRecieveUserItemNotification, object: nil)
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        userItemRequest(token: token, memberId: memberId)
        MyPageTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveUserItemNotification), name: DidRecieveUserItemNotification, object: nil)
        guard let token = UserInformation.shared.token else { return }
        guard let memberId = UserInformation.shared.memberId else { return }
        userItemRequest(token: token, memberId: memberId)
        MyPageTableView.reloadData()
    }

    // MARK:- Function
    @objc func didRecieveUserItemNotification(_ noti: Notification) {
        guard let response = noti.userInfo?["response"] as? [[String:Any]] else { return }
        print("=================noti===================")
        self.res = response
        print(response)
        print(response[0]["name"])
        print(response.count)
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

// MARK:- DataSource
extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return res.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MyPageTableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        guard let name = res[indexPath.row]["name"] as? String else { return UITableViewCell() }
        guard let imgURL = res[indexPath.row]["img"] as? String else { return UITableViewCell() }
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: imgURL) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                cell.itemImageView.image = UIImage(data: imageData)
            }
        }
        //cell.itemTitleLabel.text =
        cell.itemTitleLabel.text = name
        return cell
    }
    
    
}


