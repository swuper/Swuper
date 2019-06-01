import Foundation
import Alamofire

let DidRecieveLoginTokenNotification: Notification.Name = Notification.Name("DidRecieveLoginTokenNotification")
let DidRecieveExceptionNotification: Notification.Name = Notification.Name("DidRecieveExeptionNotification")
let DidRecieveUserItemNotification: Notification.Name = Notification.Name("DidRecieveUserItemNotification")
let DidRecieveErrorNotification: Notification.Name = Notification.Name("DidRecieveErrorNotification")
let DidRecieveAllItemNotification: Notification.Name = Notification.Name("DidRecieveAllItemNotification")
let DidRecieveCategoryItemNotification: Notification.Name = Notification.Name("DidRecieveCategoryItemNotification")

// 로그인
func LoginPost(id: String, password: String) {
    let parameters = [
        "userId" : id,
        "password" : password
    ]
    Alamofire.request("http://3.16.157.244:8090/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .validate { request, response, data in
            return .success
        }
        .responseJSON { response in
            switch response.result {
            //성공일 때
            case .success( _):
                print("success")
                //print(response)
                guard let response = response.result.value as? [String:Any] else { return }
                print(response)
                if ((response["exception"]) != nil){
                    NotificationCenter.default.post(name: DidRecieveExceptionNotification, object: nil)
                }
                if ((response["token"]) != nil) {
                    NotificationCenter.default.post(name: DidRecieveLoginTokenNotification, object: nil, userInfo: ["response" : response])
                    UserInformation.shared.token = (response as AnyObject)["token"] as? String
                    UserInformation.shared.email = (response as AnyObject)["email"] as? String
                    UserInformation.shared.username = (response as AnyObject)["username"] as? String
                    UserInformation.shared.profileImg = (response as AnyObject)["profileImg"] as? String
                    UserInformation.shared.memberId = (response as AnyObject)["memberId"] as? Int
                }
            //실패할 때
            case .failure(_):
                print("failure")
                NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : response])
                print(response)
            }
    }
}

// 회원가입
func signUpRequest(emailAdress: String, name: String, password: String, image: UIImage) {
    let url = "http://3.16.157.244:8090/signUp"
    let parameters = [
        "email" : emailAdress,
        "username" : name,
        "password" : password
    ]
    let headers = [
        "Content-type": "multipart/form-data",
    ]
    let imageData = image.pngData()
    Alamofire.upload(
        multipartFormData: { MultipartFormData in
            // 이미지
            if let imgData = imageData {
                print("img")
                print(imgData)
                MultipartFormData.append(imgData, withName: "profile_img",fileName: "img.png", mimeType: "image/png")
            }
            // 아이디,비밀번호,이름
            for (key, value) in parameters {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }

    },usingThreshold: UInt64.init(), to: url, method: .post, headers: headers){ (result) in
        switch result {
        case .success(let upload, _, _):
            upload.responseJSON { MultipartFormData in
                print("success")
                print(MultipartFormData.response?.statusCode)
            }
        case .failure(let encodingError):
            print("failure")
            NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : encodingError])
            print(encodingError)
        }
    }
}

// 상품 등록
func itemPost(memberId: Int, category: String, type: String, name: String, price: String, openChatHref: String, place: String, startAt: String, limitMemberNumber: Int, spendTime: String, image: UIImage, text: String, token: String) {
    let url = "http://3.16.157.244:8090/members/" + String(memberId) + "/products"
    let parameters : [String:Any] = [
        "category" : category,
        "type" : type,
        "name" : name,
        "price" : price,
        "openChatHref" : openChatHref,
        "place" : place,
        "startAt" : startAt,
        "limitMemberNumber" : limitMemberNumber,
        "spendTime" : spendTime,
        "text" : text
        ]
    let headers = [
        "Authorization" : "Bearer " + token,
        "Content-type" : "multipart/form-data"
    ]
    let imageData = image.pngData()
    Alamofire.upload(
        multipartFormData: { MultipartFormData in
            // 이미지
            if let imgData = imageData {
                print("img")
                print(imgData)
                MultipartFormData.append(imgData, withName: "multipartFile",fileName: "img.png", mimeType: "image/png")
            }
            // 아이디,비밀번호,이름
            for (key, value) in parameters {
                if (value is String || value is Int) {
                    MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }
            
    },usingThreshold: UInt64.init(), to: url, method: .post, headers: headers){ (result) in
        switch result {
        case .success(let upload, _, _):
            upload.responseJSON { MultipartFormData in
                print("post-success")
            }
        case .failure(let encodingError):
            print("failure")
            NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : encodingError])
            print(encodingError)
        }
    }
}

// 사용자 상품 목록 요청
func userItemRequest(token: String, memberId: Int) {
    let parameters = [
        "page" : 0
    ]
    let headers = [
        "Authorization" : "Bearer " + token
    ]
    let url = "http://3.16.157.244:8090/members/" + String(memberId) + "/products/get?page=0"
    Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        switch response.result {
        case .success:
            print("success")
            guard let response = response.result.value as? [String:Any] else { return }
            guard let res = response["response"] as? [[String: Any]] else { return }
            NotificationCenter.default.post(name: DidRecieveUserItemNotification, object: nil, userInfo: ["response" : res])
        case .failure:
            print("failure")
            NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : response])
            print(response)
        }
    }
}

// 모든 상품 요청
func getAllItemRequest(token: String) {
    //http://3.16.157.244:8090/products/getAll
    let headers = [
        "Authorization" : "Bearer " + token
    ]
    let url = "http://3.16.157.244:8090/products/getAll?page=0"
    Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        switch response.result {
        case .success:
            print("success")
            guard let response = response.result.value as? [String:Any] else { return }
            guard let res = response["response"] as? [[String: Any]] else { return }
            print("===================")
            NotificationCenter.default.post(name: DidRecieveAllItemNotification, object: nil, userInfo: ["response" : res])
        case .failure:
            print("failure")
            NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : response])
            print(response)
        }
    }
}

// 카테고리별 상품 요청
func getCategoryItemRequest(token: String, category: String){
    let headers = [
        "Authorization" : "Bearer " + token
    ]
    //http://3.16.157.244:8090/products/get/category?category=FLOWER&page=0
    let url = "http://3.16.157.244:8090/products/get/category?category=" + category + "&page=0"
    Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        switch response.result {
        case .success:
            print("success")
            guard let response = response.result.value as? [String:Any] else { return }
            guard let res = response["response"] as? [[String: Any]] else { return }
            print("===================")
            NotificationCenter.default.post(name: DidRecieveCategoryItemNotification, object: nil, userInfo: ["response" : res])
        case .failure:
            print("failure")
            NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : response])
            print(response)
        }
    }
}

// 좋아요
func likeRequest(token: String, memberId: Int, id: Int) {
    //http://3.16.157.244:8090/products/5/like?member_id=1
    let parameters = [
        "member_id" : memberId,
        "id" : id
    ]
    let headers = [
        "Authorization" : "Bearer " + token
    ]
    let url = "http://3.16.157.244:8090/products/" + String(id) + "/like?member_id=" + String(memberId)
    Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        switch response.result {
        case .success:
            print("success")
            print("===================")
        case .failure:
            print("failure")
            NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : response])
            print(response)
        }
    }
}


// 좋아요 취소
func unlikeRequest(token: String, memberId: Int, id: Int) {
    let parameters = [
        "memberId:" : memberId,
    ]
    let headers = [
        "Authorization" : "Bearer " + token
    ]
    let url = "http://3.16.157.244:8090/products/" + String(id) + "/unlike?memberId=" + String(memberId)
    Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        switch response.result {
        case .success:
            print("success")
            print("===================")
        case .failure:
            print("failure")
            NotificationCenter.default.post(name: DidRecieveErrorNotification, object: nil, userInfo: ["Error" : response])
            print(response)
        }
    }
}
