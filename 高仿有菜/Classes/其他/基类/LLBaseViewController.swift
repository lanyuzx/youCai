//
//  LLBaseViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

let SCREEN_WITH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//以5s为基准
let SCREEN_HEIGHT_COEFFICIENT = SCREEN_HEIGHT > 568 ? 568 / SCREEN_HEIGHT : 1

let SCREEN_WITH_COEFFICIENT = SCREEN_WITH > 328 ? 328 / SCREEN_WITH : 1

//购物车通知
let LLShoppingNotification = "LLShoppingNotification"

//删除购买的商品的通知
let LLDeleteProductNotification = "LLDeleteProductNotification"

class LLBaseViewController: UIViewController {
   
      override func viewDidLoad() {
        super.viewDidLoad()
       view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBarVc = self.tabBarController as?LLTabBarController
        
        tabBarVc?.customTabBar.isHidden = false

    }

    var animationLayers: [CALayer]?
    
    // MARK: 商品添加到购物车动画
    func addProductsAnimation(_ imageView: UIImageView,endPoint:CGPoint) {
        
        if (self.animationLayers == nil)
        {
            self.animationLayers = [CALayer]();
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        transitionLayer.masksToBounds = true
        transitionLayer.cornerRadius = frame.size.width / 2
        self.view.layer.addSublayer(transitionLayer)
        self.animationLayers?.append(transitionLayer)
         let p1 = transitionLayer.position;
        let controlPoint = CGPoint(x: endPoint.x, y: p1.y)
       // let p3 = CGPoint(x: view.frame.size.width - view.frame.size.width / 5 - view.frame.size.width / 8 - 6, y: self.view.layer.bounds.size.height - 40);
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        
       let   transform = CGAffineTransform.identity
        path.move(to: CGPoint(x: p1.x, y: p1.y), transform: transform)
      // CGPathMoveToPoint(path, &transform, p1.x, p1.y)
       
       // CGPathMoveToPoint(path, nil, p1.x, p1.y);
      // path.addCurve(to:  CGPoint(x: controlPoint.x, y: controlPoint.y ), control1:  CGPoint(x: p3.x, y: p1.y - 30), control2:  CGPoint(x: p3.x, y: p3.y ), transform: transform)
       
        path.addQuadCurve(to: CGPoint(x: endPoint.x, y: endPoint.y), control: CGPoint(x: controlPoint.x, y: controlPoint.y))
        

        positionAnimation.path = path;
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.95
          groupAnimation.delegate = self;
    
        transitionLayer.add(groupAnimation, forKey: "cartParabola")
    }
    

}

extension LLBaseViewController:CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if  let count = self.animationLayers?.count {
            
            if count > 0 {
            let transitionLayer = animationLayers![0]
            transitionLayer.isHidden = true
            transitionLayer.removeFromSuperlayer()
            animationLayers?.removeFirst()
            view.layer.removeAnimation(forKey: "cartParabola")
            }
        }

    }

}
