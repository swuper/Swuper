//
//  API.swift
//  Swuper
//
//  Created by 박주현 on 28/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import Foundation
import UIKit

class Api:NSObject{
    static var shared = Api()
    var MainUrl:String = "http://3.16.157.244:8090/" //반드시 설정해줘야함
    var CompleteJson:[String:Any] = [:]
    var ResultString:String = "normal"
    var token = ""
    var category = ""
    var items:[[String:Any]]? = []
    
    //http://3.16.157.244:8090/products/get/category?category=FLOWER&page=0
    func ProductGetPage(viewcontroller:ProductListTableViewController, page:Int?){
        let urlString =  (MainUrl as! String) + "products/get/category?category=" + category + "&page=" + (String(page!))
        // self.channelSongs.removeAll()
        
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "GET"// 방법 확인공간
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")//토근 인증 장소
        request.timeoutInterval = 20 // 접속 데이터 받는 대기시간
        print(token)
        print("This URL \(urlString)")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("This Api Error. Check it plz")
                print(error!)
                self.ResultString = "network error"
                let alertController = UIAlertController(title: "네트워크오류",
                                                        message: "네트워크를 확인해 주세요.",
                                                        preferredStyle: .alert)
                let cancle = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(cancle)
                viewcontroller.present(alertController, animated: true, completion:  nil)
                return
            }
            guard let data = data else {
                print("Data is empty")
                self.ResultString = "empty error"
                let alertController = UIAlertController(title: "데이터 오류",
                                                        message: "데이터 정보나 url을 확인해주세요",
                                                        preferredStyle: .alert)
                let cancle = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(cancle)
                viewcontroller.present(alertController, animated: true, completion:  nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                
                self.CompleteJson = json!
                //print("complete this API. DATA check it\(json)")
                //print(json)
                if let response = json?["response"] as? [[String:Any]]{
                    print("this in????")
                    self.items = response as! [[String:Any]]
                }
                print(self.items)
                viewcontroller.id.removeAll()
                viewcontroller.arr.removeAll()
                viewcontroller.image.removeAll()
                viewcontroller.name.removeAll()
                viewcontroller.text.removeAll()
                viewcontroller.price.removeAll()
                for (index,item) in self.items!.enumerated(){
                    viewcontroller.id.append(item["id"] as! Int)
                    viewcontroller.image.append(item["img"] as! String)
                    viewcontroller.name.append(item["name"] as! String)
                    viewcontroller.text.append(item["text"] as! String)
                    viewcontroller.price.append(item["price"] as! String)
                    viewcontroller.memberImage.append(item["memberImg"] as! String)
                }
                DispatchQueue.main.async {
                    viewcontroller.listTableView.reloadData()
                }
                
                print(viewcontroller.name)
                self.ResultString = "success"
                
            } catch {
                print("Error deserializing JSON: \(error)")
                self.ResultString = "etc error"
                let alertController = UIAlertController(title: "네트워크오류",
                                                        message: "네트워크를 확인해 주세요.",
                                                        preferredStyle: .alert)
                let cancle = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(cancle)
                viewcontroller.present(alertController, animated: true, completion:  nil)
            }
        }
        task.resume()
    }
}

