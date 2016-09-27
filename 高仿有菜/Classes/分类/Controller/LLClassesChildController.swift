//
//  LLClassesChildController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLClassesChildController: UITableViewController {

    
    var cateType = -1
    override func viewDidLoad() {
        super.viewDidLoad()
       loadResustDate()
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
            //优选商品
            //热门销售数据
            var itemsModelArr = [LLHomeModel]()
            if let itemsArr = ((response as?NSDictionary)?.object(forKey: "items")) as?NSArray {
                for index in 0..<itemsArr.count {
                    let model = LLHomeModel(dict: itemsArr[index] as! [String : AnyObject])
                    itemsModelArr.append(model)
                }
            }
            
            print(topModelArr)
            print(itemsModelArr)

            }) { (error) in
              print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
