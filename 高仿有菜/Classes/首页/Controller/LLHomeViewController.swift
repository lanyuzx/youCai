//
//  LLHomeViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//


import UIKit
import SVProgressHUD
class LLHomeViewController: LLBaseViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
          reqestDate()
          setupUI()
        navigationController?.navigationBar.isHidden = true
        
     
     
          }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func setupUI() {
        view.addSubview(homeTabView)
    
   
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
          let cycleArr = NSMutableArray(capacity: 1)
                for index in 0..<slidesArr.count {
                
                let itemModel = LLHomeModel(dict: (slidesArr[index] as? [String:AnyObject])!)
                
              cycleArr.add(itemModel)
            }
               self.homeTabView.tableHeaderView = self.tabHeadView
            self.tabHeadView.cycleArr = cycleArr


        }) { (error) in
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
                
        })
        
        return tabHead
    }()
    
     lazy var itemArr:NSMutableArray = NSMutableArray(capacity: 1)
    
    
  
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
