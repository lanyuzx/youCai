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
    
    var imgArr:NSArray? {
        
        didSet {
            
            guard   let imgsArr = imgArr else {
            return
            }
            
            cycleView.imageURLStringsGroup = [Any](imgsArr)
        
        }
    
    }
    
   
    
    var model:LLHomeModel? {
        
        didSet {
            
            titleLable.text  = model?.title
            desLable.text = model?.descr
            let priceString = (model?.price)! / 100
            priceLable.text =  "¥"  +  String (priceString) + ".00"
            
            
            let mPriceString = (model?.mprice)! / 100
            
            if mPriceString > 0 {
            origLable.isHighlighted = false
            origLable.text =  "¥"  +  String (mPriceString) + ".00"
            }else {
            origLable.isHighlighted = true
            }
       
          numberLable.text = String( model?.grossw ?? 0)  + "g/份"
            
            contentLable.text = model?.detail?.object(forKey: "content") as! String?
        
            if let moreArr = model?.more {
                
                if moreArr.count > 0 {
                    if let productArr = moreArr[0] as?NSArray {
                        if productArr.count > 0 {
                            productcontLable.text = productArr.firstObject as! String?
                            productRitLable.text = productArr.lastObject as! String?
                            productcontLable.isHighlighted = false
                            productRitLable.isHidden = false
                        }else {
                        productcontLable.isHighlighted = true
                            productRitLable.isHidden = true
                        }
                    }
                    if moreArr.count > 1 {
                            if   let saveArr = moreArr[1] as?NSArray {
                        if saveArr.count > 0 {
                            saveLable.isHighlighted = false
                            saveRitLable.isHighlighted = false
                            saveLable.text = saveArr.firstObject as! String?
                            saveRitLable.text = saveArr.lastObject as! String?
                        }else {
                        saveLable.isHighlighted = true
                            saveRitLable.isHighlighted = true

                        }
                    
                    }
                    }else {
                        saveLable.isHighlighted = true
                        saveRitLable.isHighlighted = true
                    }
                    
                    if moreArr.count > 2 {
                    if    let lifeArr = moreArr[2] as?NSArray {
                    if (lifeArr.count) > 0 {
                        lifeLable.isHighlighted = false
                        lifeRitLable.isHighlighted = false
                        lifeLable.text = lifeArr.firstObject as! String?
                        lifeRitLable.text = lifeArr.lastObject as! String?
                    }else {
                      lifeLable.isHighlighted = true
                        lifeRitLable.isHighlighted = true
                    }
                    }
                    }else {
                        lifeLable.isHighlighted = true
                        lifeRitLable.isHighlighted = true
                    }
                    if moreArr.count > 3 {
                    if  let tiShiArr = moreArr[3] as?NSArray {
                    if (tiShiArr.count) > 0 {
                        warmLable.isHighlighted = false
                        warmRitLable.isHighlighted = false
                        warmLable.text = tiShiArr.firstObject as! String?
                        warmRitLable.text = tiShiArr.lastObject as! String?

                    }else {
                        warmLable.isHighlighted = true
                        warmRitLable.isHighlighted = true
                    }
                
                }
            
                    }else {
                        warmLable.isHighlighted = true
                        warmRitLable.isHighlighted = true
                    }
                }else {
                    productcontLable.isHighlighted = true
                    productRitLable.isHidden = true

                    saveLable.isHighlighted = true
                    saveRitLable.isHighlighted = true
                    lifeLable.isHighlighted = true
                    lifeRitLable.isHighlighted = true
                    warmLable.isHighlighted = true
                    warmRitLable.isHighlighted = true
                    
                    bottomView.snp.removeConstraints()
                    bottomView.snp.makeConstraints({ (make) in
                        make.top.equalTo(productLable.snp.bottom).offset(5)
                        make.left.right.equalTo(self)
                        make.height.equalTo(10)
                    })

                }
            }
            
            
            guard  let tagNamesArr = model?.tagnames else {
                    markButton.isHidden = true
                validButton.snp.removeConstraints()
                validButton.snp.makeConstraints{ (make) in
                    make.top.equalTo((lineView.snp.bottom)).offset(15)
                    make.left.equalTo(priceLable.snp.left)
                }
                  return
            }
            
            if (tagNamesArr.count) > 0 {
                markButton.isHidden = false
            markButton.setTitle(  model?.tagnames?.firstObject as! String?
, for: .normal)
            }
            
        
        }
    
    }
    
    
    var sycleViewBlock:cycleViewClick?
    
    ///区分是否是详情页  2为详情页 1为主页
    var headViewType:NSInteger?
    
    
    init(frame: CGRect,type:NSInteger ,block:@escaping cycleViewClick) {
        super.init(frame: frame)
        headViewType = type
        sycleViewBlock = block
        backgroundColor = UIColor.white
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(bottomView.frame)
    
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
      
             if headViewType == 1 {
            homeButton(cycleContainerView: cycleContainerView)
             }else {
        deatilDes()
        }
        
      
    }
    
          // MARK: ---- 详情页下面的文字描述
    
    
     func deatilDes() {
        
        addSubview(titleLable)
        addSubview(desLable)
        addSubview(priceLable)
        addSubview(origLable)
        addSubview(numberLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(cycleView.snp.bottom).offset(12)
        }
        desLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable.snp.left)
            make.top.equalTo(titleLable.snp.bottom).offset(12)
            make.width.equalTo(SCREEN_WITH  *  0.7)
        }
        
        priceLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(desLable.snp.bottom).offset(12)
        }
        
        origLable.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.right).offset(15)
            make.top.equalTo(priceLable.snp.top)
        }
        
        numberLable.snp.makeConstraints { (make) in
            make.left.equalTo(origLable.snp.right).offset(16)
            make.top.equalTo(priceLable.snp.top)
        }
        
        //添加分割线
        lineView.alpha = 0.6
        lineView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(priceLable.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        addSubview(markButton)
        markButton.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.left)
            make.top.equalTo(lineView.snp.bottom).offset(15)
          
            
        }
        addSubview(validButton)
        validButton.snp.makeConstraints { (make) in
            make.left.equalTo(priceLable.snp.left)
            make.top.equalTo(markButton.snp.bottom).offset(15)
        }
        
        addSubview(topLineView)
        topLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(validButton.snp.bottom).offset(15)
            make.height.equalTo(12)
        }
        
        let leftView = UIView()
        addSubview(leftView)
        leftView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        leftView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(topLineView.snp.bottom).offset(15)
            make.width.equalTo(SCREEN_WITH * 0.3)
            make.height.equalTo(1)
        }
        let rightView = UIView()
        addSubview(rightView)
           rightView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        rightView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(topLineView.snp.bottom).offset(15)
             make.width.equalTo(SCREEN_WITH * 0.3)
               make.height.equalTo(1)
        }

        addSubview(sayLable)
        sayLable.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right).offset(15)
            make.top.equalTo(topLineView.snp.bottom).offset(8)
            make.right.equalTo(rightView.snp.right).offset(-15)
        }
        addSubview(contentLable)
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(sayLable.snp.bottom)
            make.right.equalTo(self).offset(-15)
        }
        
        //添加分割线
        let bootomLineView = UIView()
        bootomLineView.alpha = 0.6
        bootomLineView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        addSubview(bootomLineView)
        bootomLineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(contentLable.snp.bottom).offset(12)
            make.height.equalTo(1)
        }
        

        addSubview(weiXinLable)
        weiXinLable.snp.makeConstraints { (make) in
            make.left.equalTo(contentLable.snp.left)
            make.right.equalTo(contentLable.snp.right)
            make.top.equalTo(bootomLineView.snp.bottom).offset(12)
        }
        
        let bottonLineView = UIView()
        addSubview(bottonLineView)
        bottonLineView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        bottonLineView.snp.makeConstraints { (make) in
            make.right.left.equalTo(self)
            make.top.equalTo(weiXinLable.snp.bottom).offset(15)
                make.height.equalTo(15)
        }
        
        let bootmleftView = UIView()
        addSubview(bootmleftView)
        bootmleftView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        bootmleftView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(bottonLineView.snp.bottom).offset(15)
            make.width.equalTo(SCREEN_WITH * 0.3)
            make.height.equalTo(1)
        }
        let bootomrightView = UIView()
        addSubview(bootomrightView)
        bootomrightView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        bootomrightView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(bottonLineView.snp.bottom).offset(15)
            make.width.equalTo(SCREEN_WITH * 0.3)
            make.height.equalTo(1)
        }
        
        addSubview(productLable)
        productLable.snp.makeConstraints { (make) in
            make.left.equalTo(bootmleftView.snp.right).offset(15)
            make.top.equalTo(bottonLineView.snp.bottom).offset(8)
            make.right.equalTo(bootomrightView.snp.right).offset(-15)

        }
        addSubview(productcontLable)
        addSubview(productRitLable)
        addSubview(saveLable)
        addSubview(saveRitLable)
        addSubview(lifeLable)
        addSubview(lifeRitLable)
        addSubview(warmLable)
        addSubview(warmRitLable)
        
        productcontLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(productLable.snp.bottom).offset(12)
        }
        productRitLable.snp.makeConstraints { (make) in
            make.left.equalTo(productcontLable.snp.right).offset(8)
            make.top.equalTo(productLable.snp.bottom).offset(12)
        }
        saveLable.snp.makeConstraints { (make) in
            make.left.equalTo(productcontLable.snp.left)
            make.top.equalTo(productcontLable.snp.bottom).offset(15)
        }
        saveRitLable.snp.makeConstraints { (make) in
            make.left.equalTo(saveLable.snp.right).offset(8)
            make.top.equalTo(saveLable.snp.top)
        }
        lifeLable.snp.makeConstraints { (make) in
            make.left.equalTo(saveLable.snp.left)
            make.top.equalTo(saveLable.snp.bottom).offset(15)
        }
        lifeRitLable.snp.makeConstraints { (make) in
            make.left.equalTo(lifeLable.snp.right).offset(8)
            make.top.equalTo(lifeLable.snp.top)
        }
        
        warmLable.snp.makeConstraints { (make) in
            make.left.equalTo(lifeLable.snp.left)
            make.top.equalTo(lifeLable.snp.bottom).offset(15)
        }
       warmRitLable.snp.makeConstraints { (make) in
        make.left.equalTo(warmLable.snp.right).offset(8)
        make.right.equalTo(self).offset(-12)
        make.top.equalTo(warmLable.snp.top)
        }

        addSubview(bottomView)
        bottomView.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        bottomView.snp.makeConstraints { (make) in
            make.right.left.equalTo(self)
            make.top.equalTo(warmRitLable.snp.bottom).offset(12)
            make.height.equalTo(10)
        }

        
        
    }
    
          // MARK: ---- 主页下面的四个按钮
    
    private func homeButton(cycleContainerView:UIView) {
        
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
    //标题
    private lazy var titleLable:UILabel = {
         let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    //描述
    private lazy var desLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.numberOfLines = 0
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#9a9a9a", andAlpha: 1.0)
        return lable
    }()
    //优惠价
    private lazy var priceLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "3dca3b", andAlpha: 1.0)
        return lable
    }()
    
    //原价
    private lazy var origLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        return lable
    }()
    
    //份数
    private lazy var numberLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        return lable
    }()
    
    private lazy var lineView = UIView()
    private lazy var markButton:UIButton =  {
        
        let button = UIButton(type: UIButtonType.custom)
        button.imageView?.frame .origin.x = 5
        button.titleLabel?.frame.origin.x = (button.imageView?.frame.origin.x)! + 20
       button.setTitleColor(LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0), for: .normal)

            button.setImage( UIImage(named: "right_circle"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
    
    }()
    private lazy var validButton:UIButton =  {
        
        let button = UIButton(type: UIButtonType.custom)
        button.imageView?.frame .origin.x = 5
        button.titleLabel?.frame.origin.x = (button.imageView?.frame.origin.x)! + 20
        button.setImage( UIImage(named: "test-icon"), for: .normal)
        button.setTitle("有菜已为您检验 , 请放心购买", for: .normal)
        button.setTitleColor(LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        return button
        
    }()
    
    private lazy var topLineView:UIView =  {
        
        let v = UIView()
        v.backgroundColor = LLNetworksTools.shared().color(withHexString: "d0d0d0", andAlpha: 1.0)
        return v

    }()
    
    //菜有菜话
    private lazy var sayLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.text = "菜有菜话说"
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    private lazy var contentLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 0
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    private lazy var weiXinLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.text = "有菜客服微信号: youcai0099 ,有任何问题欢迎随时联系,朋友圈常常有福利😯!"
        lable.numberOfLines = 0
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    
    //商品信息
    private lazy var productLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.numberOfLines = 1
        lable.text = "商品信息"
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()

    //商品信息
    private lazy var productcontLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.numberOfLines = 1
        lable.textColor = UIColor.black
        return lable
    }()
    //商品信息右边
    private lazy var productRitLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    //保存
    private lazy var saveLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.numberOfLines = 1
        lable.textColor = UIColor.black
        return lable
    }()
    //商品信息右边
    private lazy var saveRitLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    //保质期
    private lazy var lifeLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.numberOfLines = 1
        lable.textColor = UIColor.black
        return lable
    }()
    //商品信息右边
    private lazy var lifeRitLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.numberOfLines = 1
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()

    // 温馨提示
    private lazy var warmLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.numberOfLines = 1
        lable.textColor = UIColor.black
        return lable
    }()
    //商品信息右边
    private lazy var  warmRitLable:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.numberOfLines = 0
        lable.textColor = LLNetworksTools.shared().color(withHexString: "#646464", andAlpha: 1.0)
        return lable
    }()
    
     lazy var bottomView:UIView = UIView()


}

extension LLHomeTableHeaderView:SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
      
        sycleViewBlock!(UIButton(),index)
    }


}
