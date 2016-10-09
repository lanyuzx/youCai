//
//  LLClassesChildCell.swift
//  高仿有菜
//
//  Created by 周尊贤 on 16/9/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

protocol classesChildCellBuyProductDelegate {
    
    func childCellbuyProuductDelegate(iconImage:UIImageView,model:LLHomeModel,imagePoint:CGPoint)
}

class LLClassesChildCell: UITableViewCell {
    
      var delegate:classesChildCellBuyProductDelegate?
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
                packageImageView.isHidden = true

            }
          
            if (model?.buyCount)! > 0 {
                
                bugCountLable.isHidden = false
                bugCountLable.text = String( model?.buyCount ?? 0)
            
            }else {
                bugCountLable.isHidden = true
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
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
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(contentView).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
            make.width.equalTo(110)
        }
        packageImageView.isHidden = true
        iconImageView.addSubview(packageImageView)
        packageImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.top.equalTo(iconImageView.snp.top).offset(12)
        }
        unitLable.snp.makeConstraints { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.left.equalTo(titleLable.snp.left)
        }
        priceLable.snp.makeConstraints { (make) in
            make.top.equalTo(unitLable.snp.bottom).offset(15)
            make.left.equalTo(unitLable.snp.left)
        }
        mPriceLable.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.right).offset(12)
            make.centerY.equalTo(priceLable)
        }
        let shopbgView = UIView()
          shopbgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LLClassesChildCell.buyProductClick)))
        contentView.addSubview(shopbgView)
        shopbgView.backgroundColor =  UIColor.init(red: 233 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 0.78)
        shopbgView.layer.cornerRadius = 30 / 2
        shopbgView.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }

    shopbgView.addSubview(shopImageView)
        shopImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LLClassesChildCell.buyProductClick)))
    shopImageView.isUserInteractionEnabled = true
      shopImageView.snp.makeConstraints { (make) in
      make.centerX.equalTo(shopbgView)
      make.centerY.equalTo(shopbgView)
      make.height.equalTo(25)
      make.width.equalTo(25)
        }
        shopImageView.addSubview(bugCountLable)
        bugCountLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(shopImageView).offset( -shopImageView.frame.size.height / 2)
            make.centerX.equalTo(shopImageView).offset(shopImageView.frame.size.width / 2)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }

    
    }
    
          // MARK: ---- 购买的方法
    
    func buyProductClick()  {
        
        model?.buyCount  = (model?.buyCount)! + 1
        
        bugCountLable.isHidden = false
        bugCountLable.text = String((model?.buyCount) ?? 0)
        let point = self.convert(iconImageView.center, to: self.superview)
        delegate?.childCellbuyProuductDelegate(iconImage: iconImageView, model: model!,imagePoint:point )
        
        
        let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        shakeAnimation.duration = 0.35
        shakeAnimation.fromValue = NSNumber(value: -5)
        shakeAnimation.toValue = NSNumber(value: 5)
        shakeAnimation.autoreverses = true
        bugCountLable.layer.add(shakeAnimation, forKey: nil)
          }
    
     // MARK: ---- 懒加载
    
    
    ///产品图片
    private lazy var iconImageView = UIImageView()
    //标题
    private lazy var titleLable:UILabel =  {
        
        let lable = UILabel()
        lable.textColor = UIColor.black
        lable.font = UIFont.boldSystemFont(ofSize: 14)
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
     lazy var bugCountLable:UILabel =  {
        
        let lable = UILabel()
        lable.backgroundColor =  UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
        lable.textColor = UIColor.white
        lable.textAlignment = .center
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 15 / 2
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.isHidden = true

        return lable
        
    }()
    //包邮
    private lazy var packageImageView = UIImageView(image: UIImage(named: "bao"))


    
    

}
