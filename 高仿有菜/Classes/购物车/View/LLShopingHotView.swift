//
//  LLShopingHotView.swift
//  高仿有菜
//
//  Created by JYD on 16/10/9.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLShopingHotView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
         backgroundColor = UIColor.init(red: 233 / 255.0, green: 233 / 255.0, blue: 233 / 255.0, alpha: 0.78)
        dataSource = self
        delegate = self
        requestDate()
        register(LLChildCollectionViewCell.self, forCellWithReuseIdentifier: "LLShopingHotView")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
          // MARK: ---- 请求数据
    
    private func requestDate() {
        
        LLNetworksTools.request(with: httpRequestType.requestTypeGet, withUrlString: "https://api.youcai.xin/item/guess?cates=201%2C202%2C202%2C101%2C303%2C301%2C301&ids=160%2C70%2C37%2C228%2C277%2C171%2C24", withParameters: nil, withSuccessBlock: { (respose) in
            
            if   let itemsArr = (respose as?NSDictionary)?.object(forKey: "items") as?[Any] {
                for index in 0..<itemsArr.count {
                    let model = LLHomeModel(dict: itemsArr[index] as! [String : AnyObject])
                    self.itemsModel.append(model)
                    
                }
            self.reloadData()
            }

            }) { (error) in
                
        }
    }
    
    lazy var itemsModel = [LLHomeModel]()
    
    

}

extension LLShopingHotView:UICollectionViewDataSource,UICollectionViewDelegate {
    

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemsModel.count
    
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLShopingHotView", for: indexPath) as?LLChildCollectionViewCell
        
        cell?.model = itemsModel[indexPath.row]
        
        return cell!
    
    }
    
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (SCREEN_WITH - 10 - 10) / 2  , height: 220)
        
    }


}
