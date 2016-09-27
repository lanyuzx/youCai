//
//  LLClassesChildCell.swift
//  高仿有菜
//
//  Created by 周尊贤 on 16/9/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClassesChildCell: UITableViewCell {

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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(unitLable)
        contentView.addSubview(priceLable)
        contentView.addSubview(shopImageView)
        shopImageView.addSubview(bugCountLable)
    
    }
    
     // MARK: ---- 懒加载
    ///产品图片
    private lazy var iconImageView = UIImageView()
    //标题
    private lazy var titleLable:UILabel =  {
        
        let lable = UILabel()
        lable.textColor = UIColor.black
        lable.font = UIFont.boldSystemFont(ofSize: 15)
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
    //购物车
    private lazy var shopImageView = UIImageView()
    //购买个数
    private lazy var bugCountLable:UILabel =  {
        
        let lable = UILabel()
        lable.backgroundColor = UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
        lable.textColor = UIColor.white
        lable.layer.masksToBounds = true
        lable.layer.cornerRadius = 20 / 2
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        return lable
        
    }()

    
    

}
