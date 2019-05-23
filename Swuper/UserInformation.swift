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
    
    var token: String?
    var memberId: Int?
    var username: String?
    var profileImg: String?
    var email: String?
}
