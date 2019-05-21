//
//  UserInformation.swift
//  Swuper
//
//  Created by 박주현 on 19/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import Foundation
import UIKit

class UserInformation {
    static let shared = UserInformation()
    
    var itemClass: String?
    var category: String?
    var itemClassTitle: String?
    var openKakaoURL: String?
    var place: String?
    var date: String?
    var limitedPeople: String?
    var useTime: String?
    var itemImage: UIImage?
    var explanation: String?
}
