//
//  LLDetailBoottomView.swift
//  高仿有菜
//
//  Created by 周尊贤 on 16/10/3.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLDetailBoottomView: UIView {
    
    var model:LLHomeModel? {
        
        didSet {
            
            if let moreArr = model?.more {
                let  prdouctInfo = NSMutableString()
                
                if moreArr.count > 0 {
                    for index in 0..<moreArr.count {
                        let childArr = moreArr[index] as!NSArray
                        if childArr.count > 0 {
                            
                            for prdouctIndex in 0..<childArr.count {
                                
                                let info = childArr[prdouctIndex]
                                
                                if prdouctIndex == 0 {
                                    prdouctInfo.append(info as!String + "    ")
                                    
                                }else if prdouctIndex == 1 {
                                    prdouctInfo.append(info as!String + "\n")
                                }
                            }
                        }
                        
                    }
                }
                productcontLable.text = prdouctInfo as String
            
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
    // MARK: ---- 添加第二个Cell上的子视图
    private func setupUI(){
        
        //商品信息
        addSubview(productLable)
        productLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(8)
        }
        let bootmleftView = UIView()
        addSubview(bootmleftView)
        bootmleftView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        bootmleftView.snp.makeConstraints { (make) in
            make.right.equalTo(productLable.snp.left).offset(-15)
            make.centerY.equalTo(productLable)
            make.width.equalTo(SCREEN_WITH * 0.2)
            make.height.equalTo(1)
        }
        let bootomrightView = UIView()
        addSubview(bootomrightView)
        bootomrightView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        bootomrightView.snp.makeConstraints { (make) in
            make.left.equalTo(productLable.snp.right).offset(15)
            make.centerY.equalTo(productLable)
            
            make.width.equalTo(SCREEN_WITH * 0.2)
            make.height.equalTo(1)
        }
        addSubview(productcontLable)
        productcontLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self ).offset(-15)
            make.top.equalTo(productLable.snp.bottom).offset(15)
        }

        
    }
    
    // MARK: ---- 懒加载
    //商品信息
    private lazy var productLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.text = "商品信息"
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    
    //商品信息
    private lazy var productcontLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.numberOfLines = 0
        lable.textColor = UIColor.darkGray
        return lable
    }()

}
