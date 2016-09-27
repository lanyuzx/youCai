//
//  LLClassesChildController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClassesChildController: UIViewController {

    
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
            }) { (error) in
              print(error)
        }
    }

   
    // MARK: ---- 懒加载
    lazy var childColletionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "LLClassesChildController")
         collectionView.isHidden = true
        return collectionView
    }()
    lazy var childTabView:UITableView = {
       let tabView = UITableView(frame: self.view.bounds, style: .grouped)
        tabView.dataSource = self
        tabView.delegate = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "LLClassesChildController")
    return tabView
    }()
    private lazy var topsArr = [LLHomeModel]()
    private lazy var itemsArr = [LLHomeModel]()


}

extension LLClassesChildController:UICollectionViewDataSource,UICollectionViewDelegate {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
    return 10
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLClassesChildController", for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    
    }
    
}

extension LLClassesChildController:UITableViewDataSource,UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LLClassesChildController", for: indexPath)
    return cell
    }


}
