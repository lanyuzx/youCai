//
//  LLShopEmptyView.swift
//  高仿有菜
//
//  Created by JYD on 16/10/9.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLShopEmptyView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
         backgroundColor = UIColor.init(red: 233 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 0.78)
        addSubview(bgImageView)
        addSubview(textLable)
        addSubview(hotLable)
        addSubview(hotColloctionView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(25)
            make.centerX.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        textLable.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }
        hotLable.snp.makeConstraints { (make) in
            make.top.equalTo(textLable.snp.bottom).offset(20)
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
        
        hotColloctionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(hotLable.snp.bottom).offset(12)
            make.height.equalTo(240)
        }
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    // MARK: ---- 懒加载

    lazy var hotColloctionView:LLShopingHotView = {
        let layout = UICollectionViewFlowLayout()
        //横向滚动
        layout.scrollDirection = .horizontal
        let collectionView = LLShopingHotView(frame: CGRect.zero, collectionViewLayout: layout)
        
        return collectionView
    
    }()
    lazy var bgImageView = UIImageView(image:  UIImage(named: "empty"))
    lazy var textLable:UILabel = {
        let lable = UILabel()
        lable.text = "购物车是空的,去逛购物商城吧"
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textColor = UIColor.darkGray
        return lable
        
    }()
    
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


