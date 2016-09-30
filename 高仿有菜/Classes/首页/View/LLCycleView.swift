//
//  LLCycleView.swift
//  高仿有菜
//
//  Created by JYD on 16/9/30.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SDCycleScrollView
class LLCycleView: UIView {

    typealias cycleViewClick = ( _ cycleItem:NSInteger )->Void
    
    var cycleArr:NSArray?  {
        didSet {
           
            guard  let imgArr = cycleArr else {
            return
            }
            cycleView.imageURLStringsGroup =  [Any](imgArr)
           
        }
        
    }
    
    var  cycleViewBlock :cycleViewClick?
    
    init(frame: CGRect,block:@escaping cycleViewClick) {
        super.init(frame: frame)
        cycleViewBlock = block
        addSubview(cycleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ---- 懒加载
    private lazy var cycleView:SDCycleScrollView = {
        let cycleV = SDCycleScrollView(frame: self.bounds, delegate: nil, placeholderImage: UIImage.init(named: "top"))
        cycleV?.delegate = self
        return cycleV!
        
    }()
    private lazy var  imgaeUrlStringArr = [String]()

}

extension LLCycleView:SDCycleScrollViewDelegate {
    


}
