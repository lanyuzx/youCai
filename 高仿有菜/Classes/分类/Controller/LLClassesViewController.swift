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
        setupNavView()
    setUpUnderLineEffect { (isUnderLineDelayScroll, underLineH, underLineColor, isUnderLineEqualTitleWidth) in
        }
        view.backgroundColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
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
     // MARK: ---- 添加导航栏
    private func setupNavView() {
        
        let navView = UIView()
        view.addSubview(navView)
        navView.backgroundColor = UIColor.white
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(64)
        }
        
        navView.addSubview(changeButton)
        changeButton.addTarget(self, action: #selector(LLClassesViewController.changeButtonClick), for: UIControlEvents.touchUpInside)
        changeButton.snp.makeConstraints { (make) in
            make.right.equalTo(navView).offset(-15)
            make.centerY.equalTo(navView).offset(5)
            make.width.equalTo(40)
            make.height.equalTo(40)
            
        }
        
        //搜索的 View
        let serachView = UIView()
        serachView.layer.cornerRadius = 7.0
        serachView.layer.masksToBounds = true
         serachView.backgroundColor =  UIColor.init(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1.0)
        navView.addSubview(serachView)
        serachView.snp.makeConstraints { (make) in
            make.right.equalTo(changeButton.snp.left).offset(-15)
            make.centerY.equalTo(navView).offset(10)
            make.height.equalTo(35)
            make.width.equalTo(SCREEN_WITH * 0.65)
        }
        
        let leftImageView = UIImageView(image: UIImage(named: "Magnifier"))
        leftImageView.isUserInteractionEnabled = true
       serachView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(serachView).offset(12)
            make.centerY.equalTo(serachView)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        serachView.addSubview(searchFiled)
        
        searchFiled.snp.makeConstraints { (make) in
            make.left.equalTo(serachView).offset(30)
            make.top.bottom.right.equalTo(serachView)
        }

     
        
    }
    
          // MARK: ---- 懒加载
    
    private lazy var changeButton:UIButton  = {
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named:"Table"), for: .normal)
        button.setImage(UIImage(named:"coll"), for: UIControlState.selected)
        return button
    }()
    private lazy var searchFiled:UITextField = {
        
        let filed = UITextField()
        filed.placeholder = "请输入关键字"
        filed.addTarget(self, action: #selector(LLHomeNavSearchView.searFiledClick), for: .editingChanged)
        filed.returnKeyType = .search
        filed.delegate = self
        return filed
        
    }()

    
          // MARK: ---- 按钮的点击方法 切换布局
    func searFiledClick() {
        
        print(searchFiled.text)
        
    }
    func changeButtonClick()  {
           changeButton.isSelected = !changeButton.isSelected
     for vc in childViewControllers {
        
            let childVc = vc as!LLClassesChildController
            
            if changeButton.isSelected {
                childVc.childTabView.isHidden = false
                childVc.childColletionView.isHidden = true
                childVc.childTabView.reloadData()
            
            } else {
                childVc.childTabView.isHidden = true
                childVc.childColletionView.isHidden = false
                childVc.childColletionView.reloadData()
            }
            
        }
    }
   
}

extension LLClassesViewController:UITextFieldDelegate {

}
