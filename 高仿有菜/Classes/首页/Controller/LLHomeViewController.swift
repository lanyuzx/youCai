//
//  LLHomeViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLHomeViewController: LLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
          reqestDate()
        setupUI()
          }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        view.addSubview(homeTabView)
    
    
    }
    // MARK: ---- 请求数据
    private func reqestDate() {
        LLNetworksTools.request(with: httpRequestType.requestTypeGet, withUrlString: "https://api.youcai.xin/app/home", withParameters: nil, withSuccessBlock: { (response) in
            
            let responseDict = response as? 
            
        }) { (error) in
            
            print(error)
            
        }
        
    }

        // MARK: ---- 懒加载控件
    
    private lazy var homeTabView:UITableView = {
        
        let tabView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT), style: .grouped)
        tabView.delegate = self
        tabView.dataSource = self
       // tabView.tableHeaderView =
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "LLHomeViewController")
        return tabView
    
    }()
    
}

extension LLHomeViewController:UITableViewDataSource,UITableViewDelegate {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 6;
    
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLHomeViewController", for: indexPath)
        
        return cell
    
    }
    
    
   
     public func numberOfSections(in tableView: UITableView) -> Int   {
    return 1;
   }
    

}
