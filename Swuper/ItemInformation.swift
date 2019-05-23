//
//  File.swift
//  Swuper
//
//  Created by 박주현 on 23/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import Foundation
import UIKit

struct ItemInformation {
    static var itemInfo = ItemInformation()
    static var firstPage = FirstPage()
    static var secondPage = SecondPage()
    static var flag = Flag()
    
    struct FirstPage {
        var productCategory: String?
        var serviceCategory: String?
        var price: String?
        var name: String?
        var openChatHref: String?
    }
    struct SecondPage {
        var place: String?
        var startAt: String?
        var limitMemberNumber: Int?
        var spendTime: String?
    }
    
    struct Flag {
        var firstFlag: Bool?
        var secondFlag: Bool?
    }
    
    
//    var limitMemberNumber: Int?
//    var itemImage: UIImage?
//    var name: String?
//    var openChatHref: String?
//    var place: String?
//    var price: String?
//    var productCategory: String?
//    var serviceCategory: String?
//    var spendTime: String?
//    var startAt: String?
//    var text: String?
}
