//
//  LLClassesViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
//cate 对应的  1 2 3 4
// https://api.youcai.xin/item/list?cate=2&length=10&start=0
class LLClassesViewController: YZDisplayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setUpAllViewController()
        
    setUpUnderLineEffect { (isUnderLineDelayScroll, underLineH, underLineColor, isUnderLineEqualTitleWidth) in
        }
    }
    
          // MARK: ---- 添加对应的子控制器
    private func setUpAllViewController() {
       
        let vegetablesVc = LLClassesChildController()
        vegetablesVc.title = "蔬菜"
        vegetablesVc.cateType = 1
        addChildViewController(vegetablesVc)
        let eggesVc = LLClassesChildController()
        eggesVc.title = "蛋类"
          eggesVc.cateType = 2
         addChildViewController(eggesVc)
        let oilVc = LLClassesChildController()
        oilVc.title = "粮油"
        oilVc.cateType = 3
        addChildViewController(oilVc)
        let fushiVc = LLClassesChildController()
        fushiVc.title = "副食"
            fushiVc.cateType = 4
        addChildViewController(fushiVc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
