//
//  LLShoppingCell.swift
//  高仿有菜
//
//  Created by JYD on 16/10/8.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLShoppingCell: UITableViewCell {
    
    var model:LLHomeModel? {
        
        didSet {
            if (model?.imgs?.count)! > 0 {
                if  let urlString = model?.imgs?.firstObject as?String {
                    let url = URL(string: urlString)
                    iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "selected"))
                }
            }
            titleLable.text = model?.title
     let unit  = (String( model?.quantity ?? 0) + (model?.unit)! +  "/份") + "/"
   let price =  String(((model?.price) ?? 0) / 100) + ".00" + "元"
    priceLable.text = unit + price

        
  countLable.text = String(model?.buyCount ?? 0)
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
          // MARK: ---- 添加 UI 视图
    func setupUI()  {
        addSubview(iconView)
        addSubview(titleLable)
        addSubview(priceLable)
        addSubview(subButton)
        addSubview(countLable)
        addSubview(addButton)
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(80)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(12)
            make.top.equalTo(iconView.snp.top)
            make.right.equalTo(self).offset(-15)
        }
        priceLable.snp.makeConstraints { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(12)
            make.left.equalTo(titleLable.snp.left)
            
        }
        addButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-12)
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        countLable.snp.makeConstraints { (make) in
            make.right.equalTo(addButton.snp.left).offset(-15)
            make.centerY.equalTo(addButton)
        }
        subButton.snp.makeConstraints { (make) in
            make.right.equalTo(countLable.snp.left).offset(-15)
            make.top.equalTo(addButton.snp.top)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
    }
    
          // MARK: ---- 懒加载
    
    private lazy var iconView = UIImageView()
    
    private lazy var titleLable:UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLable:UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.darkGray
        
        return label
    }()
    private lazy var countLable:UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        
        return label
    }()
    private lazy var subButton:UIButton = {
        
        let btn = UIButton()
      btn.setImage( UIImage(named: "sub_btn"), for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.imageView?.frame.origin.x = 0
        btn.titleLabel?.frame.origin.x = (btn.imageView?.frame.origin.x)! + (btn.imageView?.frame.size.width)! + 20
        return btn
    }()
    private lazy var addButton:UIButton = {
        
        let btn = UIButton()
        btn.setImage(  UIImage(named: "add_btn"), for: .normal)
        
        return btn
    }()

    

}
