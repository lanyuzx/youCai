//
//  LLMoreInfoViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/10/10.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLMoreInfoViewController: LLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "更多信息"
        
       
        view.addSubview(moreInfoTabView)
        moreInfoTabView.tableFooterView = UIView()
        
        let versionLable = UILabel()
        versionLable.font = UIFont.boldSystemFont(ofSize:  16)
        versionLable.textColor = UIColor.darkGray
        
        let  version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as!String
        versionLable.text =   "版本:  " + version
        view.addSubview(versionLable)
        versionLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-16)
        }
        

         }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBarVc = self.tabBarController as?LLTabBarController
        
        tabBarVc?.customTabBar.isHidden = true
        
        navigationController?.navigationBar.isHidden = false
        cacheNumberLabel.text = String().appendingFormat("%.2fM", FileTool.folderSize(LLCachePath)).cleanDecimalPointZear()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ---- 懒加载
    
    lazy var moreInfoArr = ["设置密码","客服电话","使用帮助","拼团流程","问题反馈","清除缓存","关于有菜"]
    lazy var cacheNumberLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor.colorWithCustom(180, g: 180, b: 180)
        return lable
    }()
    lazy var moreInfoTabView:UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 64), style: .plain)
        tabView.bounces = false
        tabView.dataSource = self
        tabView.delegate = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "LLMeViewController")
        return tabView
    }()


}

extension LLMoreInfoViewController :UITableViewDataSource,UITableViewDelegate ,UIAlertViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moreInfoArr.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "LLMeViewController", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = moreInfoArr[indexPath.row]
        
        if indexPath.row == 5 {
          cell.contentView.addSubview(cacheNumberLabel)
            cacheNumberLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(cell.contentView)
                make.centerY.equalTo(cell.contentView)
            })
          
        
        }

    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        if indexPath.row == 2 {
            let helpVc = LLDetailsController()
            helpVc.title = "使用帮助"
            helpVc.detailUrl = "https://m.youcai.xin/help"
            navigationController?.pushViewController(helpVc, animated: true)
        
        }else if indexPath.row == 6 {
            let abooutVc = LLDetailsController()
            abooutVc.title = "关于有菜"
            abooutVc.detailUrl = "https://m.youcai.xin/about"
            navigationController?.pushViewController(abooutVc, animated: true)

        } else if indexPath.row == 1 {
            
            let alterView = UIAlertView(title: "400-860-0216", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "呼叫")
            alterView.show()
        
        } else if indexPath.row == 5 {
            
            FileTool.cleanFolder(LLCachePath) { () -> () in
                self.cacheNumberLabel.text = "0M"
                let alterView = UIAlertView(title: "清除缓存成功", message: "", delegate:  nil, cancelButtonTitle: "取消")
                alterView.show()
            }
            
            }else {
            let loginVc = LLLoginViewController()
            present(loginVc, animated: true, completion: nil)
        }
       

    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            
       
            
            
            UIApplication.shared.openURL(NSURL(string :"tel://"+"\("4008600216")")! as URL)
        
        }
    }
    
    
}
