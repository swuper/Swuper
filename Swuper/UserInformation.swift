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
