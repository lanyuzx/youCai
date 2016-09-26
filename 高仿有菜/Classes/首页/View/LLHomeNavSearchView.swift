//
//  LLHomeNavSearchView.swift
//  高仿有菜
//
//  Created by 周尊贤 on 16/9/24.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit

class LLHomeNavSearchView: UIView {
typealias searchTextFiled = (_ searchFiled:UITextField )->Void
    
    var searchBlock:searchTextFiled?
    
    init(frame: CGRect,filedBlock:@escaping searchTextFiled) {
        super.init(frame: frame)
        
        searchBlock = filedBlock
        backgroundColor =  UIColor.init(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1.0)
        
        setupUI()
        layer.masksToBounds = true
        layer.cornerRadius = 7
        alpha = 0.4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        let leftImageView = UIImageView(image: UIImage(named: "Magnifier"))
        leftImageView.isUserInteractionEnabled = true
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
           make.left.equalTo(self).offset(12)
          make.centerY.equalTo(self)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
      addSubview(searchFiled)
        
        searchFiled.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.top.bottom.right.equalTo(self)
        }
        
        
    }
    
    private lazy var searchFiled:UITextField = {
        
        let filed = UITextField()
        filed.placeholder = "请输入关键字"
        filed.addTarget(self, action: #selector(LLHomeNavSearchView.searFiledClick), for: .touchUpInside)
        filed.returnKeyType = .search
        filed.delegate = self
        return filed
    
    }()
    
    func searFiledClick() {
        
    print(searchFiled.text)
        
    }

}

extension LLHomeNavSearchView:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        searchBlock!(textField)
        return true
    }

}
