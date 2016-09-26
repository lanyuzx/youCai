//
//  LLHomeModel.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLHomeModel: NSObject {
    
    //轮播器图片对应的标题
    var title:String?
      var type = -1
    //轮播图片
    var img:String?
    //存放跳转 url 的ID
    var link:NSDictionary?
    
 // //精品推荐***************************************精品推荐//
   
    
    //详情页
    var detail:NSDictionary?
    ///详情页轮播图
      var imgs:NSArray?
    //详情页描述
    var descr:String?
    ///cel 上的配图
    var thumb:String?
    //来源那个农庄
    var farm:String?
    var id = -1

     // //详情页***************************************详情页//
    ///儿童 成人
    var tagnames:NSArray?
    //m价格
    var mprice = -1    //价格
    var price = -1 
    //已售
    var sales = -1
    var grossw = -1
    
    //更多
    var more:NSArray?
    
    
    
    
    
    init(dict:[String:AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }


}
