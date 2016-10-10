//
//  LLMeTableViewCell.swift
//  高仿有菜
//
//  Created by JYD on 16/10/10.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLMeTableViewCell: UITableViewCell {

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
        accessoryType = .disclosureIndicator
        addSubview(iconImageView)
        addSubview(titleLable)
        addSubview(InfoLable)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalTo(self)
        }
        
        InfoLable.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupUI()  {
        
    }
    
          // MARK: ---- 懒加载
    
    lazy var iconImageView  = UIImageView()
    
    lazy var titleLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = UIColor.darkGray
        return lable
    
    }()
    
    lazy var InfoLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.textColor = UIColor.darkGray
        return lable
        
    }()

}
