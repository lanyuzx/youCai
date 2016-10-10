//
//  LLMeHeadView.swift
//  高仿有菜
//
//  Created by JYD on 16/10/10.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import BAButton

class LLMeHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
          // MARK: ---- 添加子视图
    func setupUI()  {
        
        addSubview(bgImageView)
        bgImageView.isUserInteractionEnabled = true
        bgImageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self)
        }
        
        let iconView = UIView()
        iconView.backgroundColor = UIColor.white
        iconView.layer.cornerRadius = 40
        iconView.layer.masksToBounds = true
        bgImageView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImageView)
            make.centerY.equalTo(bgImageView).offset(-15)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        iconView.addSubview(loginImageView)
        loginImageView.isUserInteractionEnabled = true
        loginImageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(iconView)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        loginImageView.layer.cornerRadius = 30
        loginImageView.layer.masksToBounds = true
        
        let loginLable = UILabel()
        loginImageView.addSubview(loginLable)
        loginLable.text = "点击登录"
        loginLable.textAlignment = .center
        loginLable.font = UIFont.boldSystemFont(ofSize: 16)
        loginLable.textColor = UIColor.darkGray
        loginLable.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(loginImageView)
        }
        //添加底部的三个按钮
        let bottomView = UIView()
        bgImageView.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.clear
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bgImageView)
            make.bottom.equalTo(bgImageView).offset(-15)
            make.height.equalTo(60)
        }
        
        //订单优惠
        
    let orderBtn = BACustomButton(witAligenmentStatus: BAAligenmentStatusTop)
        orderBtn.setImage( UIImage(named: "ordertop"), for: .normal)
        orderBtn.setTitle("我的订单", for: .normal)
        orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        orderBtn.setTitleColor(UIColor.white, for: .normal)
        bottomView.addSubview(orderBtn)
        orderBtn.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView).offset(15)
            make.centerY.equalTo(bottomView)
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
       
        
        //优惠红包
        let couponBtn = BACustomButton(witAligenmentStatus: BAAligenmentStatusTop)
        couponBtn.setImage( UIImage(named: "coupon"), for: .normal)
        couponBtn.setTitle("优惠红包", for: .normal)
        couponBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        couponBtn.setTitleColor(UIColor.white, for: .normal)
        bottomView.addSubview(couponBtn)
        couponBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView)
            make.centerY.equalTo(bottomView)
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
       
      
      //地址管理
        
        let addressBtn = BACustomButton(witAligenmentStatus: BAAligenmentStatusTop)
        addressBtn.setImage( UIImage(named: "addtop"), for: .normal)
        addressBtn.setTitle("地址管理", for: .normal)
        addressBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        addressBtn.setTitleColor(UIColor.white, for: .normal)
        bottomView.addSubview(addressBtn)
        addressBtn.snp.makeConstraints { (make) in
            make.right.equalTo(bottomView).offset(-15)
            make.centerY.equalTo(bottomView)
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
        let leftLineView = UIView()
        bottomView.addSubview(leftLineView)
        leftLineView.backgroundColor = UIColor.white
        leftLineView.snp.makeConstraints { (make) in
            make.left.equalTo(addressBtn.snp.left).offset(-(SCREEN_WITH - 80) / 2)
            make.centerY.equalTo(bottomView)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }

        let rightLineView = UIView()
        bottomView.addSubview(rightLineView)
        rightLineView.backgroundColor = UIColor.white
        rightLineView.snp.makeConstraints { (make) in
            make.left.equalTo(orderBtn.snp.right).offset((SCREEN_WITH - 80) / 2)
            make.centerY.equalTo(bottomView)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }


        
    }
    
          // MARK: ---- 懒加载
    
    lazy var bgImageView = UIImageView(image: UIImage(named: "txbg"))
    
    lazy var loginImageView = UIImageView(image: UIImage(named: "user_avatar"))
    

}
