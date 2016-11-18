//
//  LLBaseDetailViewController.swift
//  高仿有菜
//
//  Created by JYD on 2016/10/17.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLBaseDetailViewController: LLBaseViewController {
    
   

    var countTime: Timer?{
        get {
            if self.countTime == nil {
            
                self.countTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LLBaseDetailViewController.aaa), userInfo: nil, repeats: false)
            }
        return self.countTime
        }
        
        set {
        
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func aaa()  {
        
    }
      // MARK: ---- 懒加载
    
    /// 背景的 view
    lazy var bgScrollView =  UIScrollView()
    /// 标题
    lazy var titleText = UILabel()
       /// 介绍
    lazy var introduceText = UILabel()
    
    

}
