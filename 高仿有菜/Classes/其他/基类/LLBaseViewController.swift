//
//  LLBaseViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

let SCREEN_WITH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//以5s为基准
let SCREEN_HEIGHT_COEFFICIENT = SCREEN_HEIGHT > 568 ? 568 / SCREEN_HEIGHT : 1

let SCREEN_WITH_COEFFICIENT = SCREEN_WITH > 328 ? 328 / SCREEN_WITH : 1



class LLBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
