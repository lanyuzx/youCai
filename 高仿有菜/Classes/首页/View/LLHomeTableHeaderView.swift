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
    typealias cycleViewClick = (_ leftButton:UIButton, _ cycleItem:NSInteger )->Void
    
    var cycleArr:NSMutableArray?  {
        didSet {
            let  imageUrlArr = NSMutableArray(capacity: 1)
            for index in 0..<cycleArr!.count {
                let model = cycleArr?[index] as?LLHomeModel
                guard   let strURL = model?.img else {
                return
                }
                imageUrlArr.add(strURL)
            }
             cycleView.imageURLStringsGroup = [Any](imageUrlArr)

        }
    
    }
    
    var sycleViewBlock:cycleViewClick?
    
    init(frame: CGRect ,block:@escaping cycleViewClick) {
        super.init(frame: frame)
        sycleViewBlock = block
        backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        let cycleContainerView = UIView()
        cycleContainerView.backgroundColor = UIColor.orange
        addSubview(cycleContainerView)
        cycleContainerView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(150)
        }
        cycleContainerView.addSubview(cycleView)
        cycleView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(cycleContainerView)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(cycleContainerView.snp.bottom).offset(18)
        }
        
        //添加底部的四张图片
        // 图片数组
        let images = ["woman", "confinement", "baby", "old"]
        // 标题数组
        let titles = ["孕妇", "月子", "宝宝", "老人"]
        
            let maxCols = 4
            let buttonW: CGFloat = 50
            let buttonH: CGFloat = buttonW
            let buttonStartX: CGFloat = 20
            let xMargin: CGFloat = (SCREEN_WITH  - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
            
            // 创建按钮
            for index in 0..<images.count {
                let button = YMVerticalButton()
                button.tag = index + 10
                button.setImage(UIImage(named: images[index]), for: .normal)
                button.setTitle(titles[index], for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                button.frame.size.width = buttonW
                button.frame.size.height = buttonH
                button.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
                
                // 计算 X、Y
                let row = Int(index / maxCols)
                let col = index % maxCols
                let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
                let buttonMaxY: CGFloat = CGFloat(row) * buttonH
                let buttonY = buttonMaxY
                button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
               bottomView.addSubview(button)
            }
        
          }
    
    func btnClick(button:UIButton)  {
        
        sycleViewBlock!(button,-1)
        
        
    }
          // MARK: ---- 懒加载
    private lazy var cycleView:SDCycleScrollView = {

        let cycleV = SDCycleScrollView(frame:    CGRect(x: 0, y: 0, width: 0, height: 0), delegate: nil, placeholderImage: UIImage.init(named: "top"))
           cycleV?.delegate = self
        return cycleV!
        
    }()

}

extension LLHomeTableHeaderView:SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
        sycleViewBlock!(UIButton(),index)
    }


}
