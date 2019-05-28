import Foundation
import UIKit

struct ItemInformation {
    static var itemInfo = ItemInformation()
    static var firstPage = FirstPage()
    static var secondPage = SecondPage()
    static var flag = Flag()
    
    struct FirstPage {
        var category: String?
        var type: String?
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
}
