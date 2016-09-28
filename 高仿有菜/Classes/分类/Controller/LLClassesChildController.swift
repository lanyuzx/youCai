//
//  LLClassesChildController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClassesChildController: LLBaseViewController {

    
    var cateType = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
       loadResustDate()
        
        view.addSubview(childColletionView)
       view.addSubview(childTabView)
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
             // MARK: ---- 请求数据
    private func loadResustDate() {
        let urlString = "https:api.youcai.xin/item/list?cate=\(cateType)&length=10&start=0"
        LLNetworksTools.request(with: httpRequestType.requestTypeGet, withUrlString: urlString, withParameters: nil, withSuccessBlock: { (response) in
            
            //热门销售数据
            var topModelArr = [LLHomeModel]()
            if let topArr = ((response as?NSDictionary)?.object(forKey: "tops")) as?NSArray {
                for index in 0..<topArr.count {
                    let model = LLHomeModel(dict: topArr[index] as! [String : AnyObject])
                    topModelArr.append(model)
                }
            }
            self.topsArr = topModelArr
            //优选商品
            //热门销售数据
            var itemsModelArr = [LLHomeModel]()
            if let itemsArr = ((response as?NSDictionary)?.object(forKey: "items")) as?NSArray {
                for index in 0..<itemsArr.count {
                    let model = LLHomeModel(dict: itemsArr[index] as! [String : AnyObject])
                    itemsModelArr.append(model)
                }
            }
            self.itemsArr = itemsModelArr
            self.childColletionView.reloadData()
            self.childTabView.reloadData()
            }) { (error) in
              print(error)
        }
    }

   
    // MARK: ---- 懒加载
    lazy var childColletionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 165), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
         collectionView.register(LLChildCollectionViewCell.self, forCellWithReuseIdentifier: "LLClassesChildController")
        collectionView.backgroundColor = UIColor.init(red: 233 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 0.78)
         collectionView.isHidden = true
         collectionView.register(LLChildCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "LLChildCollectionHeaderView")
        return collectionView
    }()
    lazy var childTabView:UITableView = {
       let tabView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WITH, height: SCREEN_HEIGHT - 165), style: .grouped)
        tabView.dataSource = self
        tabView.delegate = self
      tabView.isHidden = false
        tabView.register(LLClassesChildCell.self, forCellReuseIdentifier: "LLClassesChildController")
        tabView.register(LLChildTabHeadView.self, forHeaderFooterViewReuseIdentifier: "LLChildTabHeadView")
        

    return tabView
    }()
     lazy var topsArr = [LLHomeModel]()
     lazy var itemsArr = [LLHomeModel]()


}

extension LLClassesChildController:UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if topsArr.count > 0 {
            return 2
        }
        return 1
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if section == 0 {
            if topsArr.count > 0 {
                return topsArr.count
            }else {
                return  itemsArr.count
                
            }
        }else  {
            return itemsArr.count
        }

    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLClassesChildController", for: indexPath) as?LLChildCollectionViewCell
        if indexPath.section == 0 {
            if topsArr.count > 0 {
                let model = topsArr[indexPath.item]
                cell?.model = model
            } else {
                let model = itemsArr[indexPath.item]
                cell?.model = model
            }
            
        }else if indexPath.section == 1 {
            let model = itemsArr[indexPath.item]
            cell?.model = model
        }

        return cell!
    
    }
    
    //swift2.3
//      func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        return CGSize(width: SCREEN_WITH / 2 - 36, height: 180)
//    }
 
      //swift3.0
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (SCREEN_WITH - 10 - 10) / 2  , height: 220)

    }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
              return CGSize(width: SCREEN_WITH, height: 35)
    }
    
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "LLChildCollectionHeaderView", for: indexPath as IndexPath) as?LLChildCollectionHeaderView
        
        if indexPath.section == 0 {
            if topsArr.count > 0 {
                headView?.titleLable.text = "热门推荐"
            } else {
                headView?.titleLable.text = "优选\(title!)制品"
            }
        } else if indexPath.section == 1 {
            headView?.titleLable.text = "优选\(title!)制品"
        }
    
            return headView!
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detialVc = LLHomeDetailViewController()
        
        if indexPath.section == 0 {
            
            if topsArr.count > 0 {
                
                let model = topsArr[indexPath.row]
                detialVc.detetailURLString = "https://api.youcai.xin/item/detail?id=\(model.id )"
                
            } else {
                let model = itemsArr[indexPath.row]
                detialVc.detetailURLString = "https://api.youcai.xin/item/detail?id=\(model.id )"
                
            }
            
        }else if indexPath.section == 1 {
            let model = itemsArr[indexPath.row]
            detialVc.detetailURLString = "https://api.youcai.xin/item/detail?id=\(model.id )"
            
            
        }

        navigationController?.pushViewController(detialVc, animated: true)
    }

        
    }
    
    
    


extension LLClassesChildController:UITableViewDataSource,UITableViewDelegate,classesChildCellBuyProductDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if topsArr.count > 0 {
        return 2
        }
        return 1
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if topsArr.count > 0 {
         return topsArr.count
            }else {
                return  itemsArr.count

            }
        }else  {
        return itemsArr.count
        }
       
    
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LLClassesChildController", for: indexPath) as?LLClassesChildCell
        
        if indexPath.section == 0 {
            if topsArr.count > 0 {
        let model = topsArr[indexPath.row]
            cell?.model = model
            } else {
                let model = itemsArr[indexPath.row]
                cell?.model = model
            }
        
        }else if indexPath.section == 1 {
            let model = itemsArr[indexPath.row]
            cell?.model = model
        }
        cell?.delegate = self
    return cell!
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "LLChildTabHeadView") as?LLChildTabHeadView
        if section == 0 {
            if topsArr.count > 0 {
            headView?.titleLable.text = "热门推荐"
            } else {
               headView?.titleLable.text = "优选\(title!)制品"
            }
        } else if section == 1 {
         headView?.titleLable.text = "优选\(title!)制品"
        }
       
            return headView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detialVc = LLHomeDetailViewController()
        
        if indexPath.section == 0 {
            
            if topsArr.count > 0 {
                
             let model = topsArr[indexPath.row]
            detialVc.detetailURLString = "https://api.youcai.xin/item/detail?id=\(model.id )"
            
            } else {
                let model = itemsArr[indexPath.row]
                detialVc.detetailURLString = "https://api.youcai.xin/item/detail?id=\(model.id )"

            }
        
        }else if indexPath.section == 1 {
            let model = itemsArr[indexPath.row]
            detialVc.detetailURLString = "https://api.youcai.xin/item/detail?id=\(model.id )"

        
        }
        
        navigationController?.pushViewController(detialVc, animated: true)
    }
          // MARK: ---- 自定义代理方法
    func childCellbuyProuductDelegate(iconImage: UIImageView, modelArr: NSMutableArray) {
    
//        let preasenVC = self.parent as!LLClassesViewController
//        
//        let tabBaLable = preasenVC.tabBarItem.
        
    }

}
