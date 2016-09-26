//
//  LLHomeDetailViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/26.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLHomeDetailViewController: LLBaseViewController {
    
    var detetailURLString:String?
    var detailModel:LLHomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
   
        view.addSubview(detailTabView)
        detailTabView.tableHeaderView = detailTabHeadView
        requestDate()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       tabBarController?.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func requestDate() {
        LLNetworksTools.request(with: httpRequestType.requestTypeGet, withUrlString: self.detetailURLString, withParameters: nil, withSuccessBlock: { (date) in
         
            let itemDict = (date as?NSDictionary)?.object(forKey: "item")
            self.detailModel = LLHomeModel(dict: itemDict as! [String : AnyObject])
            print(self.detailModel)
            
            //获取轮播图数据
             self.detailTabHeadView.imgArr = self.detailModel?.imgs
            self.detailTabHeadView.model = self.detailModel
            
         if  let moreArr = self.detailModel?.more {
            if (moreArr.count) > 0 {
                if (moreArr.count) > 3 {
                    self.detailTabHeadView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT  + 250)
                }else {
                    self.detailTabHeadView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT + 100)
                }
            }else {
             self.detailTabHeadView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT + 50)
                
            }

            }
            
            
            }) { (error) in
                print(error)
 
        }
    
    }
    
    private lazy var detailTabHeadView:LLHomeTableHeaderView = {
        
        let tab = LLHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), type: 2, block: { (button, index) in
            
        })
      return tab
    
    }()
    
    private lazy var detailTabView:UITableView = {
    let tabView = UITableView()
        tabView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT )
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()

}

extension LLHomeDetailViewController:UITableViewDataSource,UITableViewDelegate {

   
    public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 2
    
    }
    
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "LLHomeDetailViewController")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "LLHomeDetailViewController")
        }
        
        return cell!
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
  
    
}
