//
//  LLChildCollectionViewCell.swift
//  高仿有菜
//
//  Created by JYD on 16/9/28.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLChildCollectionViewCell: UICollectionViewCell {
    var model:LLHomeModel? {
        
        didSet {
            if (model?.imgs?.count)! > 0 {
                if  let urlString = model?.imgs?.firstObject as?String {
                    let url = URL(string: urlString)
                    iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "selected"))
                }
            }
            titleLable.text = model?.title
            unitLable.text = (String(describing: model!.quantity) + (model?.unit)! +  "/份")
            priceLable.text =  "¥"  + String ((model?.price)! / 100) + ".00"
            
            if (model?.mprice)! > 0 {
                packageImageView.isHidden = false
                //带横画线的 lable
                let attr = NSMutableAttributedString(string: "¥"  + String (( (model?.mprice) ?? 0) / 100) + ".00")
                attr.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: 1), range: NSMakeRange(0, attr.length))
                mPriceLable.attributedText = attr
                mPriceLable.sizeToFit()
                mPriceLable.isHidden = false
            }else {
                mPriceLable.isHidden = true
                
            }
            
            
            
        }
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(unitLable)
        contentView.addSubview(priceLable)
        shopImageView.addSubview(bugCountLable)
        contentView.addSubview(mPriceLable)
        contentView.addSubview(packageImageView)
        packageImageView.isHidden = true
        iconImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.height.equalTo(80)
        }
        packageImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
            make.right.equalTo(contentView).offset(-12)
        }
        unitLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable.snp.left)
            make.top.equalTo(titleLable.snp.bottom).offset(15)
            
        }
        priceLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable.snp.left)
            make.top.equalTo(unitLable.snp.bottom).offset(15)
        }
        mPriceLable.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.right).offset(12)
            make.top.equalTo(unitLable.snp.bottom).offset(15)
        }

        let shopbgView = UIView()
        contentView.addSubview(shopbgView)
        shopbgView.backgroundColor =  UIColor.init(red: 233 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 0.78)
        shopbgView.layer.masksToBounds = true
        shopbgView.layer.cornerRadius = 25 / 2
        shopbgView.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        shopbgView.addSubview(shopImageView)
        shopImageView.layer.masksToBounds = true
        shopImageView.isUserInteractionEnabled = true
        shopImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(shopbgView)
            make.centerY.equalTo(shopbgView)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        shopImageView.addSubview(bugCountLable)
        bugCountLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(shopImageView).offset( -shopImageView.frame.size.height)
            make.centerX.equalTo(shopImageView).offset(shopImageView.frame.size.width)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }

    }
    
    // MARK: ---- 懒加载
    ///产品图片
    private lazy var iconImageView = UIImageView()
    //标题
    private lazy var titleLable:UILabel =  {
        
        let lable = UILabel()
        lable.textColor = UIColor.black
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.numberOfLines = 0
        return lable
        
    }()
    //分量
    private lazy var unitLable:UILabel =  {
        
        let lable = UILabel()
        lable.textColor = UIColor.darkGray
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        return lable
        
    }()
    //价钱
    private lazy var priceLable:UILabel =  {
        
        let lable = UILabel()
        lable.textColor = UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        return lable
        
    }()
    // 原价钱
    private lazy var mPriceLable:UILabel =  {
        
        let lable = UILabel()
        lable.textColor = UIColor.darkGray
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.isHidden = true
        return lable
        
    }()
    
    //购物车
    private lazy var shopImageView = UIImageView(image: UIImage(named: "car_no"))
    //购买个数
    private lazy var bugCountLable:UILabel =  {
        
        let lable = UILabel()
        lable.backgroundColor = UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
        lable.textColor = UIColor.white
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 20 / 2
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.isHidden = true
        return lable
        
    }()
    //包邮
    private lazy var packageImageView = UIImageView(image: UIImage(named: "bao"))
    
    

}
