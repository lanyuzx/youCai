//
//  LLCycleViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import SVProgressHUD
//https://api.youcai.xin/combo/list
//详情
//https://api.youcai.xin/combo/detail?id=21
class LLCycleViewController: LLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "宅配周期购"
      view.addSubview(cycleTabView)
        requstDate()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 请求数据
    private func requstDate() {
        
        SVProgressHUD.show(withStatus: "正在拼命加载中")
        LLNetworksTools.request(with: httpRequestType.requestTypeGet, withUrlString: "https://api.youcai.xin/combo/list", withParameters: nil, withSuccessBlock: { (date) in
                let responseDict = date as? NSDictionary
                //获取 tab 模型数组
                guard   let combosArr = responseDict?.object(forKey: "combos") as?NSArray else {
                    
                    SVProgressHUD.showError(withStatus: "数据异常!!")
                    return
                }
                var tempItemModel = [LLHomeModel]()
                for index in 0..<combosArr.count {
                    
                    let itemModel = LLHomeModel(dict: (combosArr[index] as? [String:AnyObject])!)
                    
                    tempItemModel.append(itemModel)
                }
            self.dataSource = tempItemModel
            self.cycleTabView.reloadData()
            SVProgressHUD.dismiss()

            
            }) { (error) in
                  SVProgressHUD.showError(withStatus: "数据异常!!")
        }
         }
    
    // MARK: ---- 懒加载控件
    
    private lazy var cycleTabView:UITableView = {
        let tabView = UITableView(frame: self.view.bounds , style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(LLHomeTableViewCell.self, forCellReuseIdentifier: "LLCycleViewController")
        tabView.separatorStyle = .none
        return tabView
        
    }()

     lazy var  dataSource = [LLHomeModel]()

  
}

extension LLCycleViewController:UITableViewDataSource,UITableViewDelegate {
  
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return dataSource.count;
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LLCycleViewController", for: indexPath) as?LLHomeTableViewCell
            let model = dataSource[indexPath.row]
            cell?.model = model
            return cell!
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 140
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailModel = self.dataSource[indexPath.row]
        
        let detailVc = LLHomeDetailViewController()
        
        
        detailVc.detetailURLString = "https://api.youcai.xin/combo/detail?id=\(detailModel.id )"
        
        
        self.navigationController?.pushViewController(detailVc, animated: true)
        

        
    }
        

}
