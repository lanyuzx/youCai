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
    
            //获取轮播图数据
           
            self.detailTabView.reloadData()
            self.detailTabHeadView.imgArr = self.detailModel?.imgs
            self.detailTabHeadView.model = self.detailModel
//         if  let moreArr = self.detailModel?.more {
//            if (moreArr.count) > 0 {
//                if (moreArr.count) > 3 {
//                    self.detailTabHeadView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT  + 250)
//                }else {
//                    self.detailTabHeadView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT + 100)
//                }
//            }else {
//             self.detailTabHeadView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT + 50)
//                
//            }
//
//            }
            
            
            }) { (error) in
                print(error)
 
        }
    
    }
    
     lazy var detailTabHeadView:LLHomeTableHeaderView = {
        
        let tab = LLHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), type: 2, block: { (button, index) in
            
        })
      return tab
    
    }()
    
    private lazy var detailTabView:UITableView = {
    let tabView = UITableView()
        tabView.frame = CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT )
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "LLHomeDetailViewController")
        
        
        return tabView
    }()

}

extension LLHomeDetailViewController:UITableViewDataSource,UITableViewDelegate {

   
    public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if  let imgsArr = detailModel?.detail?.object(forKey: "imgs") as?NSArray {
            
            if imgsArr.count > 0 {
                
                return 3
            }else {
            return 2
            }
            
        }
        return 2
    
    }
    
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "LLHomeDetailViewController", for: indexPath)
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            
          cell.contentView.addSubview(detailTabHeadView)
          detailTabHeadView.frame = (cell.contentView.bounds)
        
          
        }else if indexPath.row ==  1 {
            
            if let farmStrng = detailModel?.farm {
                
                cell.textLabel?.text = "产地: " + (farmStrng)

            }
            cell.accessoryType = .disclosureIndicator
            

        
        }else {
            
            if  let imgsArr = detailModel?.detail?.object(forKey: "imgs") as?NSArray {
                
                if imgsArr.count > 0 {
                    
              cell.textLabel?.text = "查看图文详情"
            cell.accessoryType = .disclosureIndicator
                }
                
            }
        
        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       
        if indexPath.row == 0 {
            
            
            if let model = (self.detailModel?.more) {
                
                if model.count > 0 {
                    
                    if let tagNameArr = detailModel?.tagnames {
                        
                        if (tagNameArr.count) > 0 {
                            return (SCREEN_HEIGHT + 180) * (SCREEN_HEIGHT_COEFFICIENT)
                        }else {
                            return (SCREEN_HEIGHT + 150) * (SCREEN_HEIGHT_COEFFICIENT)
                        }

                        
                    }else {
                     return (SCREEN_HEIGHT + 180) * (SCREEN_HEIGHT_COEFFICIENT)
                    }
                    
                    
                
                   
                }else {
                    return SCREEN_HEIGHT + 20

                }
                
            }
            
        
        }
        
        return 44
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let cell = tableView.cellForRow(at: indexPath)
           
            
//            guard let isSelect = detailModel?.isSelectCell else {
//                
//                return
//            }
            
          detailModel?.isSelectCell = !(detailModel?.isSelectCell)!
            
            print(detailModel?.isSelectCell)
            
        
            
           
            
           
           
        }
        
        

        
    }
    func getTextHeght(textString:String,font:UIFont,size:CGSize) -> CGFloat {
        
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = textString.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size.height
        
        
    }
  
    
}
