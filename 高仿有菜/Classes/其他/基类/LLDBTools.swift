//
//  LLDBTools.swift
//  高仿有菜
//
//  Created by JYD on 2016/11/17.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import FMDB
class LLDBTools: NSObject {
    
     static let DBManager = LLDBTools()
    
    var db:FMDatabase?
    
    var modelArr = [LLHomeModel]()
    
    

     /// 初始化数据库
     func initDateBase() {
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]) as NSString
        let sqlFilePath = path.appendingPathComponent("youCai.sqlite") as NSString;
        db = FMDatabase(path: (sqlFilePath ) as String! );
        
        print(sqlFilePath)
        
        if (db?.open())! {
        let  susscess  = db?.executeStatements("CREATE TABLE IF NOT EXISTS t_youCai (id INTEGER NOT NULL ,  title TEXT NOT NULL, buyCount INTEGER DEFAULT 1 ,price INTEGER DEFAULT 0 ,quantity INTEGER DEFAULT 0,imgs TEXT ,unit TEXT)")
            
            if susscess == true {
                print("创表成功")
            }
        }
    
    }
    
    func insertDateOrUpdateDate(model:LLHomeModel) {
        //"SELECT * FROM t_youCai WHERE id= \(ID)"
        let set = db?.executeQuery("SELECT * FROM t_youCai WHERE title= ?", withArgumentsIn: [model.title ?? ""])
        
        if set?.next() == true {
            
        db?.executeUpdate("UPDATE t_youCai SET buyCount= ?  WHERE title = ?", withArgumentsIn: [model.buyCount,model.title ?? ""])
            
        }else {
            
            let sql = "INSERT INTO t_youCai (id,title,buyCount,price,quantity,imgs,unit) "+"VALUES (?,?,?,?,?,?,?)"
            
             db?.executeUpdate(sql, withArgumentsIn: [model.id,model.title ?? "有菜",model.buyCount,model.price,model.quantity,model.imgs?.firstObject as?String ?? "",model.unit ?? ""])
        
        }
        
    }
    
    func delectDate(model:LLHomeModel)  {
        let sql = "DELETE FROM t_youCai WHERE title = ?"
        db?.executeUpdate(sql, withArgumentsIn: [model.title ?? ""])
    }
    
    func selectDate() -> [LLHomeModel] {
        
         initDateBase()
        
         let sql = "SELECT * FROM t_youCai "
         let set = db?.executeQuery(sql, withArgumentsIn: nil)
        
        let model:LLHomeModel = LLHomeModel()
        
        while set?.next() == true {
            
            model.id = Int ((set?.int(forColumn: "id"))!)
            model.title = set?.string(forColumn: "title")
            model.buyCount = Int ((set?.int(forColumn: "buyCount"))!)
           model.price = Int ((set?.int(forColumn: "price"))!)
            model.quantity = Int((set?.int(forColumn: "quantity"))!)
          model.img = set?.string(forColumn: "imgs")
            model.unit = set?.string(forColumn: "unit")
            
           modelArr.append(model)
            
        }
        
      return modelArr
    }


}

