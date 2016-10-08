//
//  LLShoppingViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import BACustomAlertView
//https://api.youcai.xin/item/guess?cates=201%2C202%2C202%2C101%2C303%2C301%2C301&ids=160%2C70%2C37%2C228%2C277%2C171%2C24
//热门推荐产品https://api.youcai.xin/item/guess?cates=201%2C202%2C202%2C101%2C303%2C301%2C301&ids=160%2C70%2C37%2C228%2C277%2C171%2C24
////购物车数据  已经添加过的https://api.youcai.xin/item/brief?ids=160%2C70%2C37%2C228%2C277%2C171%2C24
class LLShoppingViewController: LLBaseViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
                //接受通知监听
            NotificationCenter.default.addObserver(self, selector:#selector(didMsgRecv(notification:)),
                                                       name: NSNotification.Name(rawValue: LLShoppingNotification), object: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "购 物 车"
      view.addSubview(shopTabView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "咨询", style: .plain, target: self, action: #selector(LLShoppingViewController.consultingClick))
   
        let headView = UIView(frame:  CGRect(x: 0, y: 0, width: SCREEN_WITH, height: 35))
        headView.backgroundColor = UIColor.blue
       let infoBtn = UIButton(type: .custom)
        infoBtn.setTitle("左滑条目删除商品", for: .normal)
        infoBtn.setTitleColor(UIColor.white, for: .normal)
        infoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        infoBtn.setImage( UIImage(named: "Icon"), for: .normal)
        headView.addSubview(infoBtn)
        infoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(headView).offset(12)
            make.centerY.equalTo(headView)
        }
        shopTabView.tableHeaderView = headView
        shopTabView.tableFooterView = LLShopTabFootView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: 180))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if buyProdectArr.count < 1 {
            
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
          // MARK: ---- 一些点击方法
    //右边自选的点击方法
    func consultingClick() {
    
    }
    //通知处理函数
    func didMsgRecv(notification:NSNotification){
        let notificationDict = notification.object as?NSDictionary
        let product = notificationDict?.object(forKey: "model")
        buyProdectArr.add(product )
        
         let dict = NSMutableDictionary(capacity: 1)
        
        for index  in 0..<buyProdectArr.count {
            
            let model = buyProdectArr[index] as!LLHomeModel
            
          
            dict.setObject(model, forKey: model.title as! NSCopying )
            
            }
        
        
        buyProdectArr = NSMutableArray(array: dict.allValues)
      
        
        shopTabView.reloadData()
    }
    // MARK: ---- 懒加载
    
    lazy var buyProdectArr = NSMutableArray(capacity: 1)
    lazy var shopTabView:UITableView = {
        
        let tabView = UITableView(frame:  CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 64), style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(LLShoppingCell.self, forCellReuseIdentifier: "LLShoppingViewController")
        return tabView
    
    }()
}

extension LLShoppingViewController:UITableViewDelegate,UITableViewDataSource ,UIAlertViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    return buyProdectArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLShoppingViewController", for: indexPath) as!LLShoppingCell
        
        cell.model = buyProdectArr[indexPath.row] as?LLHomeModel
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        if buttonIndex == 1 {
            let webView = UIWebView()
            let urlString = URL(string: "400-860-0216")
            webView.loadRequest(NSURLRequest(url: urlString!) as URLRequest)
        }
    }
}
