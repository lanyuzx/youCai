//
//  LLMeViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
//使用帮助接口https://m.youcai.xin/help

//关于有菜https://m.youcai.xin/about
class LLMeViewController: LLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
      view.addSubview(meTabView)
    
         meTabView.tableHeaderView =    LLMeHeadView(frame:    CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT * 0.4)) { (button) in
            let loginVc = LLLoginViewController()
           self.present(loginVc, animated: true, completion: nil)
        }
   
        meTabView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
    }
    
      // MARK: ---- 懒加载
    
    lazy var meTabView:UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT  - 64), style: .plain)
        tabView.dataSource = self
        tabView.delegate = self
        tabView.register(LLMeTableViewCell.self, forCellReuseIdentifier: "LLMeViewController")
        return tabView
    }()
   

}

extension LLMeViewController:UITableViewDelegate,UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
    return 4
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LLMeViewController", for: indexPath) as!LLMeTableViewCell
         
        if indexPath.row == 0 {
            
            cell.iconImageView.image = UIImage(named: "wdtc")
            cell.titleLable.text = "我的套餐"
            cell.InfoLable.text = "选菜"
        
        } else if indexPath.row == 1 {
            cell.iconImageView.image = UIImage(named: "cash")
            cell.titleLable.text = "商品兑换"
            cell.InfoLable.text = "兑换"

        
        }else if indexPath.row == 2 {
            cell.iconImageView.image = UIImage(named: "red")
            cell.titleLable.text = "我的余额"
            cell.InfoLable.text = "余额"
        } else if indexPath.row == 3 {
            cell.iconImageView.image = UIImage(named: "setting_s")
            cell.titleLable.text = "更多信息"
            cell.InfoLable.isHidden = true
        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            
            let loginVc = LLLoginViewController()
          
           
         
            present(loginVc, animated: true, completion: nil)
            
          
            
        } else if indexPath.row == 1 {
            let loginVc = LLLoginViewController()
            present(loginVc, animated: true, completion: nil)
            
            
        }else if indexPath.row == 2 {
            let loginVc = LLLoginViewController()
            present(loginVc, animated: true, completion: nil)
        
        } else if indexPath.row == 3 {
            
            let moreInfoVc = LLMoreInfoViewController()
            
            navigationController?.pushViewController(moreInfoVc, animated: true)
            
        }

    }


}
