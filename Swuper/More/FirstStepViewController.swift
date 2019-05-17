//
//  FirstStepViewController.swift
//  Swuper
//
//  Created by 박주현 on 15/05/2019.
//  Copyright © 2019 박주현. All rights reserved.
//

import UIKit
import iOSDropDown

class FirstStepViewController: UIViewController {
 
    //MARK:- Properties
    var pageControl = UIPageControl()
    //var itemClassList = ["상품", "클래스"]
//    var categoryList = ["꽃", "문구류", "수제먹거리", "악세서리", "캔들,디퓨저", "공예품"]
    
    // MARK:- IBOulet
    @IBOutlet var itemClassDropDown: DropDown!
    @IBOutlet var categoryDropDown: DropDown!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var kakaoTalkURLTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemClassDropDown.optionArray = ["상품", "클래스"]
        categoryDropDown.optionArray = ["꽃", "문구류", "수제먹거리", "악세서리", "캔들,디퓨저", "공예품"]
        itemClassDropDown.backgroundColor = UIColor.white
        
        
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


