//
//  LLBaseNavController.swift
//  单糖
//
//  Created by JYD on 16/8/11.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLBaseNavController: UINavigationController {

    
    var popDelegate:UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        popDelegate = interactivePopGestureRecognizer?.delegate
        interactivePopGestureRecognizer?.delegate = nil
        self.delegate = self
        navigationBar.barStyle = .default
//        navigationBar.barTintColor = UIColor.red
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonClick() {
    
        popViewController(animated: true)
    }
    
 

}

extension LLBaseNavController:UINavigationControllerDelegate {
    // 导航控制器跳转完成的时候调用
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if viewController == viewControllers[0] {
            interactivePopGestureRecognizer?.delegate = popDelegate
        }else {
        
        interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
         // 设置非根控制器导航条内容
        if viewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let btn = UIButton(type: .custom)
            btn.setBackgroundImage(UIImage(named: "nav_back"), for: .normal)
              btn.setBackgroundImage(UIImage(named: "nav_back"), for: .highlighted)
            btn.sizeToFit()
            btn.addTarget(self, action: #selector(LLBaseNavController.backButtonClick), for: .touchUpInside)
                     let item = UIBarButtonItem(customView: btn)
            
            viewController.navigationItem.leftBarButtonItem = item
        }
        
         super.pushViewController(viewController, animated: true)
    }

}



