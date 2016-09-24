//
//  LLHomeViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//


import UIKit
import SVProgressHUD
import MJRefresh
class LLHomeViewController: LLBaseViewController {
   
     // MARK: ---- 控制器生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
          reqestDate()
          setupUI()
      
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:   UIImage(named: "sao"), style: .plain, target: self, action: #selector(LLHomeViewController.leftBarItemClick))
        
     
        let seachView = LLHomeNavSearchView(frame: CGRect(x: 40, y: 0, width: SCREEN_WITH - 80, height: 30), filedBlock: { (textFiled) in
         
            print(textFiled.text)
        })
        
        navigationController?.navigationBar.addSubview(seachView)
        
        
        
        
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1、设置导航栏半透明
        navigationController?.navigationBar.isTranslucent = true
        
        // 2、设置导航栏背景图片
  navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        // 3、设置导航栏阴影图片
        navigationController?.navigationBar.shadowImage = UIImage()
        
      

    }
   
    func leftBarItemClick()  {
        
    }
    
     // MARK: ---- 布局子控件
    private func setupUI() {
        view.addSubview(homeTabView)
        
        homeTabView.mj_header = MJRefreshNormalHeader.header(refreshingBlock: {
            
            self.reqestDate()
            
        }) as! MJRefreshHeader!
    
   
    }
    // MARK: ---- 请求数据
    private func reqestDate() {
        LLNetworksTools.request(with: httpRequestType.requestTypeGet, withUrlString: "https://api.youcai.xin/app/home", withParameters: nil, withSuccessBlock: { (response) in
            
            let responseDict = response as? NSDictionary
                   //获取 tab 模型数组
            guard   let itemArr = responseDict?.object(forKey: "items") as?NSArray else {
            
                SVProgressHUD.showError(withStatus: "数据异常!!")
                return
            }
            for index in 0..<itemArr.count {
                
                let itemModel = LLHomeModel(dict: (itemArr[index] as? [String:AnyObject])!)
                
                self.itemArr.add(itemModel)
            }
       
            self.homeTabView.reloadData()
            //获取轮播图的模型数组
            guard    let slidesArr = responseDict?.object(forKey: "slides")as? NSArray else {
                SVProgressHUD.showError(withStatus: "轮播图加载异常!!")
                return
            }
        
                for index in 0..<slidesArr.count {
                
                let itemModel = LLHomeModel(dict: (slidesArr[index] as? [String:AnyObject])!)
                
              self.cycleArr.add(itemModel)
            }
               self.homeTabView.tableHeaderView = self.tabHeadView
            self.tabHeadView.cycleArr = self.cycleArr
            
            self.homeTabView.mj_header.endRefreshing()


        }) { (error) in
              self.homeTabView.mj_header.endRefreshing()
         SVProgressHUD.showError(withStatus: "请求异常")
            
        }
        
    }

        // MARK: ---- 懒加载控件
    
    private lazy var homeTabView:UITableView = {
        
        let tabView = UITableView(frame: CGRect(x: 0, y:  0, width: SCREEN_WITH, height: SCREEN_HEIGHT  ), style: .grouped)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(LLHomeTableViewCell.self, forCellReuseIdentifier: "LLHomeViewController")
        tabView.separatorStyle = .none
        return tabView
    
    }()
    
    private lazy var tabHeadView:LLHomeTableHeaderView = {
        let tabHead =  LLHomeTableHeaderView(frame:   CGRect(x: 0, y: 0, width: SCREEN_WITH, height: 230)
            , block: { (button, index) in
                
                if button.tag  > 0 {
                
                    print("按钮的回调")
                    
                }
                
                if index > 0 {
                    
                    print("轮播")
                    let model = self.cycleArr[index]
                    print(model)

                
                }
                
        })
        
        return tabHead
    }()
    
     lazy var itemArr:NSMutableArray = NSMutableArray(capacity: 1)
    
       lazy var cycleArr:NSMutableArray = NSMutableArray(capacity: 1)
  
}

extension LLHomeViewController:UITableViewDataSource,UITableViewDelegate {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArr.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLHomeViewController", for: indexPath) as?LLHomeTableViewCell
        let model = itemArr[indexPath.row] as?LLHomeModel
        cell?.model = model
        return cell!
        
    }
    
     func numberOfSections(in tableView: UITableView) -> Int   {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame:  CGRect(x: 0, y: 0, width: SCREEN_WITH, height: 30))
        let lineView = UIView()
        headerView.addSubview(lineView)
        lineView.backgroundColor = UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
      lineView.snp.makeConstraints { (make) in
      make.left.equalTo(headerView).offset(8)
        make.top.equalTo(headerView).offset(5)
        make.bottom.equalTo(headerView).offset(-5)
        make.width.equalTo(2)
        }
        
        let textLable = UILabel()
        headerView.addSubview(textLable)
        textLable.font = UIFont.systemFont(ofSize: 12)
        textLable.text = "精品推荐"
        textLable.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(5)
            make.centerY.equalTo(headerView)
        }
            
            
        return headerView

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    


}
