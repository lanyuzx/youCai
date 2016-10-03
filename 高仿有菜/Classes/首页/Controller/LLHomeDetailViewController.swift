//
//  LLHomeDetailViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/26.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import BACustomAlertView

class LLHomeDetailViewController: LLBaseViewController {
    
    var detetailURLString:String?
    var detailModel:LLHomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(detailTabView)
            setupNavUI()
        requestDate()
        
        detailTabView.tableHeaderView = cycleView
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.isUserInteractionEnabled = true
        navigationController?.navigationBar.isHidden = true
    let tabBarVc = self.tabBarController as?LLTabBarController
        
        tabBarVc?.customTabBar.isHidden = true
        
        
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
          // MARK: ---- 添加头部的导航栏和底部的购物车
    private func setupNavUI() {
        
        let navView = UIView()
        navView.isUserInteractionEnabled = true
        navView.backgroundColor = UIColor.darkGray
        navView.alpha = 0.4
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(64)
        }
       
        let backButton = UIButton(type: .custom)
        backButton.addTarget(self, action: #selector(LLHomeDetailViewController.backButtonClick), for: .touchUpInside)
        backButton.setImage(UIImage(named: "detail_close"), for: .normal)
     navView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(navView).offset(20)
            make.centerY.equalTo(navView)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        let shareButton = UIButton(type: .custom)
        shareButton.isUserInteractionEnabled = true
        shareButton.setImage(UIImage(named: "detail_share"), for: .normal)
        navView.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(LLHomeDetailViewController.shareButtonClick), for: .touchUpInside)
        shareButton.snp.makeConstraints { (make) in
            make.right.equalTo(navView).offset(-20)
            make.centerY.equalTo(navView)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        
        

        //添加底部的购买的 view
        
        let  shoppView = UIView()
        view.addSubview(shoppView)
        shoppView.backgroundColor = UIColor.white
        shoppView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(64)
        }
        
        //购物车
        shoppView.addSubview(shopCarView)
        shopCarView.snp.makeConstraints { (make) in
            make.left.equalTo(shoppView).offset(25)
         make.centerY.equalTo(shoppView)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        bugCountLable.isHidden = true
        bugCountLable.font = UIFont.boldSystemFont(ofSize: 14)
        bugCountLable.textColor = UIColor.white
        bugCountLable.layer.masksToBounds = true
        bugCountLable.layer.cornerRadius = 20 / 2
        bugCountLable.textAlignment = .center
        bugCountLable.backgroundColor = UIColor.red
        shopCarView.addSubview(bugCountLable)
        bugCountLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(shopCarView).offset( -shopCarView.frame.size.height)
            make.centerX.equalTo(shopCarView).offset(shopCarView.frame.size.width)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        shoppView.addSubview(shoppingBtn)
        shoppingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        shoppingBtn.setTitle("加入购物车", for: . normal)
        shoppingBtn.setTitleColor(UIColor.red, for: .normal)
        shoppingBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shopCarView.snp.right).offset(40)
            make.centerY.equalTo(shoppView)
            make.width.equalTo(SCREEN_WITH * 0.3)
        }
        shoppingBtn.addTarget(self, action: #selector(LLHomeDetailViewController.addShopp), for: .touchUpInside)
        let bugButton = UIButton(type: .custom)
        shoppView.addSubview(bugButton)
        bugButton.setTitle("立即购买", for: .normal)
        bugButton.setTitleColor(UIColor.white, for: .normal)
        bugButton.backgroundColor = UIColor.red
        bugButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(shoppView)
            make.left.equalTo(shoppingBtn.snp.right)
        }

    
    }
    
          // MARK: ---- 按钮的点击方法
    func backButtonClick()  {
    
     navigationController!.popViewController(animated: true)
    }
    
    func shareButtonClick()  {
        //解决重复添加问题
        for v in shareView.subviews
        {
            v.removeFromSuperview()
        }
        shareView.layer.masksToBounds = true
        shareView.layer.cornerRadius = 0.7
        shareView.backgroundColor = UIColor.white
        shareView.frame = CGRect(x: 30, y: 100, width: SCREEN_WITH - 100, height: 130)
        
        let shareLable = UILabel()
        shareView.addSubview(shareLable)
        shareLable.text = "分享到"
        shareLable.textColor = UIColor.black
        shareLable.textAlignment = .center
        shareLable.autoresizingMask = .flexibleWidth
        shareLable.snp.makeConstraints { (make) in
            make.top.equalTo(shareView).offset(15)
            make.centerX.equalTo(shareView)
            
        }
        
        let weiXinButton = YMVerticalButton(type: .custom)
        shareView.addSubview(weiXinButton)
        weiXinButton.setImage(UIImage (named: "wx"), for: .normal)
        weiXinButton.setTitleColor(UIColor.black, for: .normal)
        weiXinButton.setTitle("微信好友", for: .normal)
        weiXinButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        weiXinButton.snp.makeConstraints { (make) in
            make.left.equalTo(shareView).offset(60)
            make.bottom.equalTo(shareView.snp.bottom).offset(-15)
            make.width.equalTo(55)
            make.height.equalTo(75)
        }
        
        let friendButton = YMVerticalButton(type: .custom)
        shareView.addSubview(friendButton)
        friendButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        friendButton.setTitleColor(UIColor.black, for: .normal)
        friendButton.setImage(UIImage (named: "timeline"), for: .normal)
        friendButton.setTitle("朋友圈", for: .normal)
        friendButton.snp.makeConstraints { (make) in
            make.right.equalTo(shareView).offset(-60)
            make.bottom.equalTo(shareView.snp.bottom).offset(-15)
            make.width.equalTo(55)
            make.height.equalTo(75)
        }
        
        let alterView = BACustomAlertView(customViewiew: shareView)
        alterView?.ba_show()

        
    }
    
    //加入购物车
    func addShopp()  {
        
        //添加购物车动画
        let center = CGPoint(x: shopCarView.frame.origin.x , y: shopCarView.frame.origin.y)
        let point = CGPoint(x: shoppingBtn.frame.origin.x, y: shoppingBtn.frame.origin.y)
        let path = UIBezierPath()
        path.move(to: point)
        path.addLine(to: center)
        
        let layer = CALayer()
        layer.contents = UIImage(named: "tab_tc_2")?.cgImage
        layer.contentsGravity = kCAGravityResizeAspectFill
        layer.bounds = CGRect(x: 15, y: 15, width: 30, height: 30)
        layer.masksToBounds = true
        layer.cornerRadius = 20
        shopCarView.layer.addSublayer(layer)
        layer.pathAnimation(withDuration: 1.0, path: path.cgPath, repeat: 1) {
            layer.isHidden = true
            //抖动动画
            let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            shakeAnimation.duration = 0.35
            shakeAnimation.fromValue = NSNumber(value: -5)
            shakeAnimation.toValue = NSNumber(value: 5)
            shakeAnimation.autoreverses = true
            self.bugCountLable.layer.add(shakeAnimation, forKey: nil)
            self.bugCountLable.isHidden = false
            self.bugArr.add(self.detailModel)
            self.bugCountLable.text = String(self.bugArr.count)
        }
        
        //渲染动画  放大效果
        /*
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        
        let expandAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandAnimation.duration = 0.5
        expandAnimation.fromValue = NSNumber(integerLiteral: 1)
        expandAnimation.toValue = NSNumber(integerLiteral: 2)
        expandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
       let narrowAnimation =     CABasicAnimation(keyPath: "transform.scale")
        
        narrowAnimation.beginTime = 0.5
        narrowAnimation.fromValue = NSNumber(integerLiteral: 2)
        narrowAnimation.duration = 1.5
        narrowAnimation.toValue  = NSNumber(floatLiteral: 0.5)
        
        narrowAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let grops = CAAnimationGroup()
        grops.animations = [animation,expandAnimation,narrowAnimation];
        grops.duration = 2.0
        grops.isRemovedOnCompletion = false
        grops.fillMode = kCAFillModeForwards
        
        layer.add(grops, forKey: "group")

        */
        
        
    }
    
          // MARK: ---- 请求数据
    private func requestDate() {
        LLNetworksTools.request(with: httpRequestType.requestTypeGet, withUrlString: self.detetailURLString, withParameters: nil, withSuccessBlock: { (date) in
         
            if  let itemDict = (date as?NSDictionary)?.object(forKey: "item") {
             self.detailModel = LLHomeModel(dict: itemDict as! [String : AnyObject])
            }
    
            //获取轮播图数据
           
           
            self.cycleView.cycleArr = self.detailModel?.imgs
            self.detailTopCell.model = self.detailModel
            self.detailMiddleCell.model = self.detailModel
            self.detailBoottomCell.model = self.detailModel
            self.detailTabView.reloadData()
            self.detaiImageCollectionView.reloadData()

            }) { (error) in
                print(error)
 
        }
    
    }
        // MARK: ---- 懒加载
    
    lazy var cycleView:LLCycleView = {
        
        let cycleView  = LLCycleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: 150)) { (index) in
            
        }
       
        return cycleView
    
    }()
    //第一个cell上的View
    lazy var detailTopCell:LLDetailTopView = LLDetailTopView()
    
    //第二个cell上的View
    lazy var detailMiddleCell:LLDetailMiddleView = LLDetailMiddleView()
    
    lazy var detailBoottomCell:LLDetailBoottomView = LLDetailBoottomView()
    
    private lazy var detailTabView:UITableView = {
    let tabView = UITableView()
        tabView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 64 )
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "LLHomeDetailViewController")
        tabView.separatorStyle = .none
        
        return tabView
    }()
    
     lazy var detaiImageCollectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0;
//        layout.itemSize = CGSize(width: SCREEN_WITH, height: 320)
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0  , height: 0 ), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.isHidden = true
        collection.backgroundColor = UIColor.white
        collection.bounces = false
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "LLHomeDetailViewController")
  collection.isScrollEnabled = false
        collection.isScrollEnabled = false
        return collection
    }()
    //分享弹出的 View
    private lazy var shareView = UIView()

    private lazy var sharebgView = UIView()
    
    //购买个数
    private lazy var bugCountLable = UILabel()
     private lazy var shopCarView = UIImageView(image: UIImage(named: "car_no"))
    
    private lazy var shoppingBtn = UIButton()
    
    private lazy var  bugArr = NSMutableArray(capacity: 1)
}


extension LLHomeDetailViewController:UITableViewDataSource,UITableViewDelegate {

   
    public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if  let imgsArr = detailModel?.detail?.object(forKey: "imgs") as?NSArray {
            
            if imgsArr.count > 0 {
                
                return 5
            }
            
        }else {
            return 4

        }
      return 4
    }
    
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "LLHomeDetailViewController", for: indexPath)
        cell.selectionStyle = .none
        
        for v in cell.contentView.subviews {
            v.removeFromSuperview()
        }
        if indexPath.row == 0 {
          cell.contentView.addSubview(detailTopCell)
          detailTopCell.frame = (cell.contentView.bounds)
            
        
          
        }else if indexPath.row ==  1 {
            
           cell.contentView.addSubview(detailMiddleCell)
            detailMiddleCell.frame = cell.contentView.frame
        
        }else  if indexPath.row == 2 {
            
            cell.contentView.addSubview(detailBoottomCell)
            
            detailBoottomCell.frame = cell.contentView.frame
        }else if indexPath.row == 3 {
            let titleLable = UILabel()
            cell.contentView.addSubview(titleLable)
            titleLable.snp.makeConstraints({ (make) in
                make.left.equalTo(cell.contentView).offset(12)
                make.top.equalTo(cell.contentView).offset(16)
            })
            let topView = UIView()
            topView.backgroundColor = UIColor.darkGray
            cell.contentView.addSubview(topView)
            topView.snp.makeConstraints({ (make) in
                make.left.equalTo(cell.contentView).offset(12)
                make.right.equalTo(cell.contentView).offset(-12)
                make.top.equalTo(cell.contentView)
                make.height.equalTo(0.5)
            })
            
            if let farm = detailModel?.farm {
                titleLable.text = "产地:" + (farm)
            }
            let arrowImageView = UIImageView(image: UIImage(named: "user_arrow"))
            cell.contentView.addSubview(arrowImageView)
            arrowImageView.snp.makeConstraints({ (make) in
                make.right.equalTo(cell.contentView).offset(-12)
                make.top.equalTo(cell.contentView).offset(12)
                make.width.equalTo(15)
                make.height.equalTo(20)
            })

           
            let bootomView = UIView()
            bootomView.backgroundColor = UIColor.darkGray
            cell.contentView.addSubview(bootomView)
            bootomView.snp.makeConstraints({ (make) in
                make.left.equalTo(cell.contentView).offset(12)
                make.right.equalTo(cell.contentView).offset(-12)
                make.bottom.equalTo(cell.contentView)
                make.height.equalTo(0.5)
            })


        
        } else if indexPath.row == 4 {
            let titleLable = UILabel()
            cell.contentView.addSubview(titleLable)
            titleLable.snp.makeConstraints({ (make) in
                make.left.equalTo(cell.contentView).offset(12)
                make.top.equalTo(cell.contentView).offset(16)
            })
            

            titleLable.text = "产品图文详情"
            
            
            let bootomView = UIView()
            bootomView.backgroundColor = UIColor.darkGray
            cell.contentView.addSubview(bootomView)
            bootomView.snp.makeConstraints({ (make) in
                make.left.equalTo(cell.contentView).offset(12)
                make.right.equalTo(cell.contentView).offset(-12)
                make.bottom.equalTo(cell.contentView)
                make.height.equalTo(0.5)
            })
            

            let arrowImageView = UIImageView(image: UIImage(named: "user_arrow"))
            cell.contentView.addSubview(arrowImageView)
            arrowImageView.snp.makeConstraints({ (make) in
                make.right.equalTo(cell.contentView).offset(-12)
                make.top.equalTo(cell.contentView).offset(12)
                make.width.equalTo(15)
                make.height.equalTo(20)
            })
            
            cell.contentView.addSubview(detaiImageCollectionView)
            detaiImageCollectionView.snp.makeConstraints({ (make) in
                make.left.equalTo(cell.contentView).offset(12)
                make.right.equalTo(cell.contentView).offset(-12)
                make.bottom.equalTo(cell.contentView).offset(-5)
                make.top.equalTo(titleLable.snp.bottom).offset(16)
            })
            
            if  let imgsArr = detailModel?.detail?.object(forKey: "imgs") as?NSArray {
                
                if imgsArr.count > 0 {
                    
                    if (detailModel?.isSelectCell)! {
                        detaiImageCollectionView.isHidden = false
                        arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2))
                        
                    }else {
                        arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                        detaiImageCollectionView.isHidden = true
                    }
                    
                    
                    
                }
            }


        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.row == 0 {
            
            if  let tagNamesArr = detailModel?.tagnames  {
                
                if tagNamesArr.count > 0 {
                     return  210
                }
            }else {
              return  180
            }
            
            
            
           
        } else if indexPath.row == 1 {
            
            let text  = detailModel?.detail?.object(forKey: "content") as? String
            
            if text != nil {
                return (getTextHeight(textString: text! , font: UIFont.boldSystemFont(ofSize: 13), size: CGSize(width: SCREEN_WITH - 30, height: CGFloat(MAXFLOAT)))) +  100
                
            }

        
        }else if indexPath.row == 2 {
            
            if let moreArr = detailModel?.more {
                let  prdouctInfo = NSMutableString()
                
                if moreArr.count > 0 {
                    for index in 0..<moreArr.count {
                        let childArr = moreArr[index] as!NSArray
                        if childArr.count > 0 {
                            
                            for prdouctIndex in 0..<childArr.count {
                                
                                let info = childArr[prdouctIndex]
                                
                                if prdouctIndex == 0 {
                                    prdouctInfo.append(info as!String + "    ")
                                    
                                }else if prdouctIndex == 1 {
                                    prdouctInfo.append(info as!String + "\n")
                                }
                            }
                        }
                        
                    }
                }
                
                return (getTextHeight(textString: prdouctInfo as String , font: UIFont.boldSystemFont(ofSize: 13), size: CGSize(width: SCREEN_WITH - 30, height: CGFloat(MAXFLOAT)))) + 45
            }
    
        } else if indexPath.row == 4 {
            
            if (detailModel?.isSelectCell)! {
                if  let imgsArr = detailModel?.detail?.object(forKey: "imgs") as?NSArray {
                    return CGFloat ( 230 * CGFloat(imgsArr.count))
                }else {
                    return 44
                }
                
            }
        
        }
    
        return  44
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 4 {
            detailModel?.isSelectCell = !(detailModel?.isSelectCell)!
                tableView.reloadRows(at: [indexPath], with: .automatic)
            detaiImageCollectionView.reloadData()

        }else if indexPath.row == 3 {
            
            let webViewVc = LLDetailsController()
            webViewVc.detailUrl = "https://m.youcai.xin/farm/\(detailModel!.fid)"
            navigationController?.pushViewController(webViewVc, animated: true)
        
        }
        
        
 
    }
    
     // MARK: ---- 计算文字的高度
    func getTextHeight(textString:String,font:UIFont,size:CGSize) -> CGFloat {
        
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = textString.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size.height
        
        
    }
  
    
}

extension LLHomeDetailViewController:UICollectionViewDataSource,UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if  let imgsArr = detailModel?.detail?.object(forKey: "imgs") as?NSArray {
         return imgsArr.count
        }
      return 0
    }
    
    
  
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLHomeDetailViewController", for: indexPath)
        for v in cell.contentView.subviews {
            v.removeFromSuperview()
        }

        let imgeView = UIImageView()
        cell.contentView.addSubview(imgeView)
        imgeView.frame = cell.contentView.bounds
        if  let imgsArr = detailModel?.detail?.object(forKey: "imgs") as?NSArray {
            let imageUrlString = imgsArr[indexPath.item]
            imgeView.sd_setImage(with:    NSURL(string: imageUrlString as! String) as URL!
, placeholderImage: UIImage(named: "top"))

        }
        return cell
    
    }
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: SCREEN_WITH   , height: 230)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        
        //UIEdgeInsetsMake(top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets
        return UIEdgeInsetsMake(-5, 0, -5, 0)
    }

    


}
