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
    var flag = false
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
                    print("-------------------------------")
                    print(response["token"])
                    NotificationCenter.default.post(name: DidRecieveLoginTokenNotification, object: nil, userInfo: ["token" : response])
                }
            //실패할 때
            case .failure(_):
                print("failure")
                debugPrint(response)
            }
    }
}

func post(emailAdress: String, name: String, password: String, image: UIImage) {
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
