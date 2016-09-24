//
//  LLTabBarController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildViewController(childController: LLHomeViewController(), title: "首页", imageName: "tab_home")
        addChildViewController(childController: LLClassesViewController(), title: "分类", imageName: "tab_cate")
        addChildViewController(childController: LLCycleViewController(), title: "分期购", imageName: "tab_buy")
        addChildViewController(childController: LLShoppingViewController(), title: "购物车", imageName: "tab_tc")
        addChildViewController(childController: LLMeViewController(), title: "我的", imageName: "tab_me")
        
        tabBar.tintColor = UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ---- 封装添加子控制器方法
    private func addChildViewController(childController:UIViewController ,title:NSString ,imageName:NSString) {
        
       // childController.title = title as String
        childController.tabBarItem.image = UIImage(named: imageName as String + "_1" )
        childController.tabBarItem.selectedImage = UIImage(named: (imageName as String + "_2"))
        childController.tabBarItem.title = title as String
        let navVc  = LLBaseNavController(rootViewController: childController)
        addChildViewController(navVc)
        
        
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
