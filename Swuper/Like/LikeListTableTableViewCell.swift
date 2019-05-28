//
//  LikeListTableTableViewCell.swift
//  Swuper
//
//  Created by 박주현 on 29/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class LikeListTableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var informationBackView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var likeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backView.layer.cornerRadius = 10
            self.userImageView.layer.cornerRadius = 10
            self.itemImageView.layer.borderWidth = 1
            self.itemImageView.layer.borderColor = UIColor.white.cgColor
            self.itemImageView.layer.cornerRadius = 10
            self.informationBackView.layer.cornerRadius = 10
        }
    }

}
