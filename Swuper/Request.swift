//
//  Request.swift
//  Swuper
//
//  Created by 박주현 on 02/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import Foundation


func postAction(emailAdress: String, name: String, password: String) {
    let url = String("") // url 바꿔야됨
    guard let serviceUrl = URL(string: url) else { return }
    let parameterDictionary = ["email" : emailAdress, "username" : name, "password" : password ] as [String : Any] // 바꿔야되는 부분
    var request = URLRequest(url: serviceUrl)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else { return }
    request.httpBody = httpBody
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
            print(response)
        }
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print("----------error----------")
                print(error)
            }
        }
        }.resume()
}
