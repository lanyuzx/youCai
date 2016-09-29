//
//  LLTabBarController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import BAButton
class LLTabBarController: UITabBarController {
    var animationLayers: [CALayer]?
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBar()
        // Do any additional setup after loading the view.
        
        addChildViewController(childController: LLHomeViewController(), title: "首页", imageName: "tab_home")
        addChildViewController(childController: LLClassesViewController(), title: "分类", imageName: "tab_cate")
        addChildViewController(childController: LLCycleViewController(), title: "周期购", imageName: "tab_buy")
        addChildViewController(childController: LLShoppingViewController(), title: "购物车", imageName: "tab_tc")
        addChildViewController(childController: LLMeViewController(), title: "我的", imageName: "tab_me")
        
        tabBar.tintColor = UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
        
        //接受通知监听
        NotificationCenter.default.addObserver(self, selector:#selector(didMsgRecv(notification:)),
                                               name: NSNotification.Name(rawValue: LLShoppingNotification), object: nil)
        
           }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //通知处理函数
    func didMsgRecv(notification:NSNotification){
         let notificationDict = notification.object as?NSDictionary
        let productArr = notificationDict?.object(forKey: "modelArr")as!NSArray

          shoppingArr.add(productArr)
        //获取购物车btn
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(0.95))) {
            //抖动动画
            let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            shakeAnimation.duration = 0.35
            shakeAnimation.fromValue = NSNumber(value: -5)
            shakeAnimation.toValue = NSNumber(value: 5)
            shakeAnimation.autoreverses = true
            self.customTabBar.countLable.layer.add(shakeAnimation, forKey: nil)
            self.customTabBar.countLable.isHidden = false
            if self.shoppingArr.count > 0 {
                self.customTabBar.countLable.isHidden = false
                self.customTabBar.countLable.text = String(self.shoppingArr.count)
            }else {
              self.customTabBar.countLable.isHidden = true
            
            }
 
        }
        
        
             /*
      let notificationDict = notification.object as?NSDictionary
        
        let productView = notificationDict?.object(forKey: "iconImage") as!UIImageView
        
     let productArr = notificationDict?.object(forKey: "modelArr")as!NSArray
        
      shoppingArr.add(productArr)
        
        //获取购物车btn
        
        let shoppButton = customTabBar.subviews[3] as!BACustomButton
        
        //添加购物车动画
        let center = CGPoint(x: shoppButton.frame.origin.x + shoppButton.frame.size.width , y: SCREEN_HEIGHT - shoppButton.frame.size.height / 2)
        let point = CGPoint(x: (productView.frame.origin.x + productView.frame.size.height + productView.frame.origin.y) / 2, y: productView.frame.origin.y)
        let path = UIBezierPath()
        path.move(to: point)
        path.addLine(to: center)
        path.addCurve(to: CGPoint(x: productView.frame.origin.x, y: productView.frame.origin.y), controlPoint1: CGPoint(x: shoppButton.frame.origin.x, y: shoppButton.frame.origin.y), controlPoint2: CGPoint(x: shoppButton.frame.origin.x, y: shoppButton.frame.origin.y))
      //  path.addQuadCurve(to: CGPoint(x: productView.frame.origin.x, y: productView.frame.origin.y), controlPoint: CGPoint(x: productView.frame.origin.x, y: productView.frame.origin.y))
        
        let layer = CALayer()
        layer.contents = productView.image?.cgImage
        layer.contentsGravity = kCAGravityResizeAspectFill
        layer.bounds = CGRect(x: 0, y: 0, width: 35, height: 35)
        layer.masksToBounds = true
        layer.cornerRadius = 20
        productView.layer.addSublayer(layer)
        layer.pathAnimation(withDuration: 3.0, path: path.cgPath, repeat: 1) {
            layer.isHidden = true
            //抖动动画
            let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            shakeAnimation.duration = 0.35
            shakeAnimation.fromValue = NSNumber(value: -5)
            shakeAnimation.toValue = NSNumber(value: 5)
            shakeAnimation.autoreverses = true
            self.customTabBar.countLable.layer.add(shakeAnimation, forKey: nil)
            self.customTabBar.countLable.isHidden = false
           // self.bugArr.add(self.detailModel)
            if self.shoppingArr.count > 0 {
            self.customTabBar.countLable.isHidden = false
            self.customTabBar.countLable.text = String(self.shoppingArr.count)
            }
          
        }
        
*/
        
    }
     

     private lazy var shoppingArr = NSMutableArray(capacity: 1)
    lazy var customTabBar = HMTabBar()
          // MARK: ---- 自定义tabBar
    
    private func setUpTabBar() {
        
        customTabBar.frame = tabBar.frame
        customTabBar.delegate = self
        view.addSubview(customTabBar)
        tabBar.removeFromSuperview()
    
    }
    
    // MARK: ---- 封装添加子控制器方法
    private func addChildViewController(childController:UIViewController ,title:NSString ,imageName:NSString) {
        
       // childController.title = title as String
        childController.tabBarItem.image = UIImage(named: imageName as String + "_1" )
        childController.tabBarItem.selectedImage = UIImage(named: (imageName as String + "_2"))
        childController.tabBarItem.title = title as String
        customTabBar.addButton(childController.tabBarItem)
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

extension LLTabBarController:HMTabBarDelegate {
    
    func tabBar(_ TabBar: HMTabBar!, didSelectedButtonFrom from: Int, to: Int) {
        selectedIndex = to
    }

}
