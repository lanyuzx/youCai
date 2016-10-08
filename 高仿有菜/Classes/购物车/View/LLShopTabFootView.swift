//
//  LLShopTabFootView.swift
//  高仿有菜
//
//  Created by JYD on 16/10/8.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLShopTabFootView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 添加 UI 视图
    func setupUI()  {
        addSubview(hotLable)
     
        hotLable.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.centerX.equalTo(self)
        }

        let leftView = UIView()
        addSubview(leftView)
        leftView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        leftView.snp.makeConstraints { (make) in
            make.right.equalTo(hotLable.snp.left).offset( -15)
            make.centerY.equalTo(hotLable)
            make.width.equalTo(SCREEN_WITH * 0.2)
            make.height.equalTo(1)
        }
        let rightView = UIView()
        addSubview(rightView)
        rightView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        rightView.snp.makeConstraints { (make) in
            make.left.equalTo(hotLable.snp.right).offset( 15)
            make.centerY.equalTo(hotLable)
            make.width.equalTo(SCREEN_WITH * 0.2)
            make.height.equalTo(1)
        }

        
    }
    
           // MARK: ---- 懒加载
    //人们推荐
    private lazy var hotLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.text = "热门推荐"
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()

}
