//
//  YMVerticalButton.swift
//  DanTang
//
//  Created by 杨蒙 on 16/7/22.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit
import SDWebImage

class YMVerticalButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.frame.origin.x = 10
        imageView?.frame.origin.y = 0
        imageView?.frame.size.width = self.frame.size.width - 20
        imageView?.frame.size.height = (imageView?.frame.size.width)!
        // 调整文字
        titleLabel?.frame.origin.x = 0
        titleLabel?.frame.origin.y = imageView!.frame.size.height
        titleLabel?.frame.size.width = self.frame.size.width
        titleLabel?.frame.size.height = self.frame.size.height - self.titleLabel!.frame.origin.y
        
        
    }
    
}
