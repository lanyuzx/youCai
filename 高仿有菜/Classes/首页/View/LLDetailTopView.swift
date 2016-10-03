//
//  LLDetailTopView.swift
//  高仿有菜
//
//  Created by 周尊贤 on 16/10/3.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLDetailTopView: UIView {
    
    var model:LLHomeModel? {
        
        didSet {
            
            titleLable.text  = model?.title
            desLable.text = model?.descr
            if let priceString = (model?.price)
            {
            priceLable.text =  "¥"  +  String (priceString / 100) + ".00"
            }
          
            
            
            if let mPriceString = (model?.mprice) {
                if mPriceString > 0 {
                    origLable.isHighlighted = false
                    origLable.text =  "¥"  +  String (mPriceString / 100) + ".00"
                }else {
                    origLable.isHighlighted = true
                }

            }
            
            numberLable.text = String( model?.grossw ?? 0)  + "g/份"
            guard  let tagNamesArr = model?.tagnames else {
                 markButton.isHidden = true
                validButton.snp.removeConstraints()
                validButton.snp.makeConstraints{ (make) in
                    make.top.equalTo((lineView.snp.bottom)).offset(15)
                    make.left.equalTo(priceLable.snp.left)
                }
                return
            }
            
            if (tagNamesArr.count) > 0 {
                markButton.isHidden = false
                markButton.setTitle(  model?.tagnames?.firstObject as! String?
                    , for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: ---- 添加第一个Cell上的子视图
    private func setupUI(){
        
        addSubview(titleLable)
        addSubview(desLable)
        addSubview(priceLable)
        addSubview(origLable)
        addSubview(numberLable)
        addSubview(lineView)
        addSubview(markButton)
        addSubview(validButton)
        
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(12)
        }
        desLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable.snp.left)
            make.top.equalTo(titleLable.snp.bottom).offset(12)
            make.width.equalTo(SCREEN_WITH  *  0.7)
        }
        
        priceLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(desLable.snp.bottom).offset(12)
        }
        
        origLable.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.right).offset(15)
            make.top.equalTo(priceLable.snp.top)
        }
        
        numberLable.snp.makeConstraints { (make) in
            make.left.equalTo(origLable.snp.right).offset(16)
            make.top.equalTo(priceLable.snp.top)
        }
        
        //添加分割线
        lineView.alpha = 0.6
        lineView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(priceLable.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        addSubview(markButton)
        markButton.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.left)
            make.top.equalTo(lineView.snp.bottom).offset(15)
            
            
        }
        addSubview(validButton)
        validButton.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.left)
            make.top.equalTo(markButton.snp.bottom).offset(12)
        }
        
        addSubview(topLineView)
        topLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(validButton.snp.bottom).offset(12)
            make.height.equalTo(12)
        }

    }

     // MARK: ---- 懒加载
    //标题
    private lazy var titleLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    //描述
    private lazy var desLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.numberOfLines = 0
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#9a9a9a", andAlpha: 1.0)
        return lable
    }()
    //优惠价
    private lazy var priceLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "3dca3b", andAlpha: 1.0)
        return lable
    }()
    
    //原价
    private lazy var origLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        return lable
    }()
    
    //份数
    private lazy var numberLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        return lable
    }()
    
    private lazy var lineView = UIView()
    private lazy var markButton:UIButton =  {
        
        let button = UIButton(type: UIButtonType.custom)
        button.imageView?.frame .origin.x = 5
        button.titleLabel?.frame.origin.x = (button.imageView?.frame.origin.x)! + 20
        button.setTitleColor(LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0), for: .normal)
        
        button.setImage( UIImage(named: "right_circle"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
        
    }()
    private lazy var validButton:UIButton =  {
        
        let button = UIButton(type: UIButtonType.custom)
        button.imageView?.frame .origin.x = 5
        button.titleLabel?.frame.origin.x = (button.imageView?.frame.origin.x)! + 20
        button.setImage( UIImage(named: "test-icon"), for: .normal)
        button.setTitle("有菜已为您检验 , 请放心购买", for: .normal)
        button.setTitleColor(LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
        
    }()
    //分割线
    private lazy var topLineView:UIView =  {
        
        let v = UIView()
        v.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        return v
        
    }()

}
