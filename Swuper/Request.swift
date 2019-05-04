//
//  Request.swift
//  Swuper
//
//  Created by 박주현 on 02/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import Foundation
import Alamofire


func post(emailAdress: String, name: String, password: String, image: UIImage) {
    let parameters = [
        "email" : emailAdress,
        "username" : name,
        "password" : password
    ]
    
    let imageData = image.pngData()
    
    Alamofire.upload(
        multipartFormData: { MultipartFormData in
            
            // 아이디,비밀번호,이름 업로드
            for (key, value) in parameters {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            // 이미지 업로드
            guard let imgData = imageData else { return }
            MultipartFormData.append(imgData, withName: "profile_img")

            
//            MultipartFormData.append(UIImageJPEGRepresentation(UIImage(named: "1.png")!, 1)!, withName: "photos[1]", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//            MultipartFormData.append(UIImageJPEGRepresentation(UIImage(named: "1.png")!, 1)!, withName: "photos[2]", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            
            
    }, to: "url") { (result) in
        
        switch result {
        case .success(let upload, _, _):
            upload.responseJSON { response in
                print(response.result.value)
            }
        case .failure(let encodingError):
            print(encodingError)
        }
    }
}

//
//func postAction(emailAdress: String, name: String, password: String) {
//    let url = String("") // url 바꿔야됨
//    guard let serviceUrl = URL(string: url) else { return }
//    let parameterDictionary = ["email" : emailAdress, "username" : name, "password" : password ] as [String : Any] // 바꿔야되는 부분
//    var request = URLRequest(url: serviceUrl)
//    request.httpMethod = "POST"
//    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else { return }
//    request.httpBody = httpBody
//    let session = URLSession.shared
//    session.dataTask(with: request) { (data, response, error) in
//        if let response = response {
//            print(response)
//        }
//        if let data = data {
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print("----------error----------")
//                print(error)
//            }
//        }
//        }.resume()
//}
