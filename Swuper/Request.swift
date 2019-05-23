//
//  Request.swift
//  Swuper
//
//  Created by 박주현 on 02/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import Foundation
import Alamofire

let DidRecieveLoginTokenNotification: Notification.Name = Notification.Name("DidRecieveLoginTokenNotification")
let DidRecieveExceptionNotification: Notification.Name = Notification.Name("DidRecieveExeptionNotification")


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
                print(response)
            }
    }
}

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
                MultipartFormData.append(imgData, withName: "profile_img",fileName: "profile_img", mimeType: "image/png")
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
                print(MultipartFormData.result.value)
                print("--------------------------------")
                print(MultipartFormData.response)
                print("--------------------------------")
                print(MultipartFormData.response?.statusCode)
            }
        case .failure(let encodingError):
            print("failure")
            print(encodingError)
        }
    }
}

func itemPost(memberId: Int, productCategory: String, serviceCategory: String, name: String, price: String, openChatHref: String, place: String, startAt: String, limitMemberNumber: Int, spendTime: String, image: UIImage, text: String, token: String) {
    let url = "http://3.16.157.244:8090/members/" + String(memberId) + "/products"
    let parameters : [String:Any] = [
        "productCategory" : "FOOD",
        "serviceCategory" : "SPORTS",
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
        "Authorization" :  "Bearer " + token,
        "Content-type" : "multipart/form-data"
    ]
    let imageData = image.pngData()
    Alamofire.upload(
        multipartFormData: { MultipartFormData in
            // 이미지
            if let imgData = imageData {
                print("img")
                print(imgData)
                MultipartFormData.append(imgData, withName: "multipartFile",fileName: "multipartFile", mimeType: "image/png")
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
                print("success")
                print(MultipartFormData.result.value)
                print("--------------------------------")
                print(MultipartFormData.response)
                print("--------------------------------")
                print(MultipartFormData.response?.statusCode)
            }
        case .failure(let encodingError):
            print("failure")
            print(encodingError)
        }
    }
//    print(memberId)
//    print(productCategory)
//    print(serviceCategory)
//    print(name)
//    print(price)
//    print(openChatHref)
//    print(place)
//    print(startAt)
//    print(limitMemberNumber)
//    print(spendTime)
//    print(image)
//    print(text)
    
    // 상품 등록
}

func userItemRequest() {
    // 상품 목록 요청
}

func allItemRequest() {
    // 모든 상품 목록 요청
}

func detailItemRequest() {
    // 상품 상세 설명 
}
