//
//  LLMeViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
//使用帮助接口https://m.youcai.xin/help

//关于有菜https://m.youcai.xin/about
class LLMeViewController: LLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
    }
    

   

}
