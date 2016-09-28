//
//  LLChildTabHeadView.swift
//  高仿有菜
//
//  Created by JYD on 16/9/28.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLChildTabHeadView: UITableViewHeaderFooterView {

   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.init(red: 233 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 0.78)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let leftView  = UIView()
        leftView.alpha = 0.6
        leftView.backgroundColor = UIColor.darkGray
        contentView.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.right.equalTo(titleLable.snp.left).offset(-12)
            make.centerY.equalTo(titleLable)
             make.height.equalTo(0.6)
            make.width.equalTo(SCREEN_WITH * 0.2)
        }
        
        let rightView  = UIView()
           rightView.alpha = 0.6
        rightView.backgroundColor =  UIColor.darkGray
        contentView.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable.snp.right).offset(12)
            make.centerY.equalTo(titleLable)
            make.height.equalTo(0.6)
               make.width.equalTo(SCREEN_WITH * 0.2)
        }

        
    
    
    }
          // MARK: ---- 懒加载
    
    lazy var titleLable:UILabel = {
        
        let lable = UILabel()
        lable.textColor = UIColor.darkGray
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textAlignment = .center
        return lable
    
    }()
}
