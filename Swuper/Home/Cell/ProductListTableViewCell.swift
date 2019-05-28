//
//  ProductListTableViewCell.swift
//  Swuper
//
//  Created by 박주현 on 27/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet var itemImage : UIImageView!
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet weak var informationBackView: UIView!
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.backView.layer.cornerRadius = 10
            self.userImageView.layer.cornerRadius = 10
            self.itemImage.layer.borderWidth = 1
            self.itemImage.layer.borderColor = UIColor.white.cgColor
            self.itemImage.layer.cornerRadius = 10
            self.informationBackView.layer.cornerRadius = 10
        }
    }

}
