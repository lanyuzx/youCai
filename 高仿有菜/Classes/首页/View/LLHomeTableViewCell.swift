//
//  LLHomeTableViewCell.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLHomeTableViewCell: UITableViewCell {

    var model:LLHomeModel? {
        
        didSet {
            
            guard   let imageURL = model?.thumb else {
            return
            }
        backImageView.setImageWith( NSURL(string: imageURL) as! URL
, placeholderImage: UIImage(named: "top"))
        
        
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
       contentView.backgroundColor =   UIColor.init(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1.0)
        selectionStyle = .none
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
           make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(4)
            make.bottom.equalTo(self.contentView).offset(-4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
          // MARK: ---- 懒加载
    
      lazy var backImageView: UIImageView = UIImageView()
}
