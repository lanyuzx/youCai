//
//  LLHomeTableHeaderView.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SDCycleScrollView
class LLHomeTableHeaderView: UIView {
typealias cycleViewClick = (_ leftButton:UIButton )->Void
    
    
    var sycleViewBlock:cycleViewClick?
    
    init(frame: CGRect ,imageArr:NSArray ,block:@escaping cycleViewClick) {
        super.init(frame: frame)
        sycleViewBlock = block

        setupUI(imgageArr: imageArr)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(imgageArr:NSArray) {
        
        let cycleView = SDCycleScrollView(frame: bounds, imageNamesGroup: imgageArr as?[Any])
        addSubview(cycleView!)
    
    }

}
