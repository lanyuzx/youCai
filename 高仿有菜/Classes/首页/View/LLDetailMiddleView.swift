//
//  LLDetailMiddleView.swift
//  高仿有菜
//
//  Created by 周尊贤 on 16/10/3.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLDetailMiddleView: UIView {
    
    var model:LLHomeModel? {
        
        didSet {
            
        contentLable.text = model?.detail?.object(forKey: "content") as! String?

            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ---- 添加第二个Cell上的子视图
    private func setupUI(){
        
        //菜油菜花说
        addSubview(sayLable)
        sayLable.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.centerX.equalTo(self)
        }
        
        let leftView = UIView()
        addSubview(leftView)
        leftView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        leftView.snp.makeConstraints { (make) in
            make.right.equalTo(sayLable.snp.left).offset( -15)
            make.centerY.equalTo(sayLable)
            make.width.equalTo(SCREEN_WITH * 0.2)
            make.height.equalTo(1)
        }
        let rightView = UIView()
        addSubview(rightView)
        rightView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        rightView.snp.makeConstraints { (make) in
            make.left.equalTo(sayLable.snp.right).offset( 15)
            make.centerY.equalTo(sayLable)
            make.width.equalTo(SCREEN_WITH * 0.2)
            make.height.equalTo(1)
        }
        
        addSubview(contentLable)
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(sayLable.snp.bottom)
            make.right.equalTo(self).offset(-15)
        }
        
        //添加分割线
        let bootomLineView = UIView()
        bootomLineView.alpha = 0.6
        bootomLineView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        addSubview(bootomLineView)
        bootomLineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(contentLable.snp.bottom).offset(12)
            make.height.equalTo(1)
        }
        
        
        addSubview(weiXinLable)
        weiXinLable.snp.makeConstraints { (make) in
            make.left.equalTo(contentLable.snp.left)
            make.right.equalTo(contentLable.snp.right)
            make.top.equalTo(bootomLineView.snp.bottom).offset(12)
        }
        
        let bottonLineView = UIView()
        addSubview(bottonLineView)
        bottonLineView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        bottonLineView.snp.makeConstraints { (make) in
            make.right.left.equalTo(self)
            make.top.equalTo(weiXinLable.snp.bottom).offset(15)
            make.height.equalTo(12)
        }
        

    }
    // MARK: ---- 懒加载
    //菜有菜话
    private lazy var sayLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.text = "菜有菜话说"
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    private lazy var contentLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 0
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    private lazy var weiXinLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.text = "有菜客服微信号: youcai0099 ,有任何问题欢迎随时联系,朋友圈常常有福利😯!"
        lable.numberOfLines = 0
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    
}
