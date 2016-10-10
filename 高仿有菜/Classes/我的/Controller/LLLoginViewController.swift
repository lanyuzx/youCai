//
//  LLLoginViewController.swift
//  高仿有菜
//
//  Created by JYD on 16/10/10.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import BAButton
class LLLoginViewController: LLBaseViewController {

    var prewMoveY:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
    setUpNavView()
     setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
          // MARK: ---- 添加 UI 视图
    
    func setUpNavView()  {
       
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(64)
        }
        
        let backButton = UIButton()
       backButton.addTarget(self, action: #selector(LLLoginViewController.backBtnClick), for: .touchUpInside)
        backButton.setImage( UIImage(named: "nav_close"), for: .normal)
        navView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(navView).offset(15)
            make.centerY.equalTo(navView)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        let titleLable = UILabel()
        navView.addSubview(titleLable)
        titleLable.text = "登录"
        titleLable.font = UIFont.boldSystemFont(ofSize: 16)
        titleLable.textColor = UIColor.darkGray
        titleLable.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(navView)
        }
        
        let bootomLineView = UIView()
        bootomLineView.alpha = 0.65
        bootomLineView.backgroundColor = UIColor.darkGray
        navView.addSubview(bootomLineView)
        bootomLineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(navView)
            make.height.equalTo(0.6)
        }
    }
    
    func setupUI()  {
        view.addSubview(bgView)
        bgView.frame = CGRect(x: 0, y: 64, width: SCREEN_WITH, height: SCREEN_HEIGHT - 64)
        
        let loginIconView = UIImageView(image: UIImage(named: "icon_small_logo"))
        bgView.addSubview(loginIconView)
        loginIconView.snp.makeConstraints { (make) in
            make.top.equalTo(bgView).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(160)
            make.height.equalTo(160)
        }
        //登录框
        let loginView = UIView()
        bgView.addSubview(loginView)
        loginView.layer.borderWidth = 0.7
        loginView.layer.borderColor = UIColor.darkGray.cgColor
        loginView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.top.equalTo(loginIconView.snp.bottom).offset(12)
            make.height.equalTo(100)
        }
        
        let lineView  = UIView()
         lineView.alpha = 0.65
        lineView.backgroundColor = UIColor.darkGray
        loginView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerY.equalTo(loginView)
            make.left.equalTo(loginView).offset(15)
            make.right.equalTo(loginView).offset(-15)
            make.height.equalTo(0.6)
        }
        
        loginView.addSubview(phoneFild)
        phoneFild.snp.makeConstraints { (make) in
            make.left.equalTo(loginView).offset(15)
            make.top.equalTo(loginView)
            make.bottom.equalTo(lineView.snp.top)
          
        }
        
        loginView.addSubview(numberCodeFild)
        numberCodeFild.snp.makeConstraints { (make) in
            make.left.equalTo(loginView).offset(15)
            make.top.equalTo(lineView.snp.bottom)
            make.bottom.equalTo(loginView)
        }
        
        loginView.addSubview(numberCodeBtn)
        numberCodeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(loginView).offset(-15)
            make.top.equalTo(loginView)
            make.bottom.equalTo(lineView.snp.top)
            
        }
        
        //确定框
        let makeSureView = UIView()
        bgView.addSubview(makeSureView)
        makeSureView.layer.borderWidth = 0.7
        makeSureView.layer.borderColor = UIColor.darkGray.cgColor
        makeSureView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.top.equalTo(loginView.snp.bottom).offset(12)
            make.height.equalTo(50)
        }
        
        let makeSureButton = UIButton()
        makeSureButton.setTitle("确定", for: . normal)
        makeSureButton.setTitleColor(UIColor.darkGray, for: .normal)
        makeSureButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        makeSureView.addSubview(makeSureButton)
        makeSureButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(makeSureView)
        }
        
        
        //密码登录和短信登录切换
        
        let changeBtn = BACustomButton(witAligenmentStatus: BAAligenmentStatusRight)
        changeBtn.addTarget(self, action: #selector(LLLoginViewController.changeButtonClick), for: .touchUpInside)
        changeBtn.setTitle("密码登录", for: . normal)
        changeBtn.setTitle("短信快接登录", for: .selected)
        changeBtn.setTitleColor(UIColor.blue, for: .normal)
        changeBtn.setImage( UIImage(named: "login_arrow"), for: .normal)
        changeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bgView.addSubview(changeBtn)
        changeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(makeSureView.snp.bottom).offset(20)
            make.centerX.equalTo(bgView)
        }
        
        

        
        
        
    }
    
          // MARK: ---- 按钮的一些点击方法
    
    func backBtnClick() {
        
        dismiss(animated: true, completion: nil)
    }
    func changeButtonClick(btn:BACustomButton)  {

        btn.isSelected = !btn.isSelected
        
        if btn.isSelected {
            numberCodeBtn.isHidden = true
            numberCodeFild.placeholder = "请输入密码"
        
        } else {
            numberCodeBtn.isHidden = false
            numberCodeFild.placeholder = "请输入验证码"
        }
        
    }
    
        // MARK: ---- 懒加载
    
    lazy var navView = UIView()
    lazy var bgView = UIView()
    
    lazy var phoneFild:UITextField = {
        
        let fild = UITextField()
         fild.delegate = self
        fild.placeholder = "输入手机号"
        
        return fild
    
    }()
    
    lazy var numberCodeFild:UITextField = {
        
        let fild = UITextField()
        fild.delegate = self
        fild.placeholder = "请输入验证码"
        
        return fild
        
    }()
    
    lazy var numberCodeBtn:UIButton = {
        
        let btn = UIButton()
        btn.setTitle("获取验证码", for: . normal)
        btn.setTitleColor(UIColor.init(red: 10 / 255.0, green: 178 / 255.0, blue: 10 / 255.0, alpha: 1.0)
, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        return btn
    
    }()
 
}

extension LLLoginViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            let textFrame = bgView.frame
        let textY =  (textFrame.origin.y) + (textFrame.size.height)
        
        let bottomY = bgView.frame.size.height - textY
        if bottomY >= 230 {
         return
        }
        var moveY:CGFloat = 0
        if textField == phoneFild {
            moveY = 50 - bottomY
            
        }else if textField == numberCodeFild {
            moveY = 100 - bottomY

        }

        prewMoveY = moveY
        
       var frame = bgView.frame
        frame.origin.y -= moveY
        frame.size.height += moveY
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.25)
        UIView.setAnimationBeginsFromCurrentState(true)
         bgView.frame = frame
        UIView.commitAnimations()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        var  moveY:CGFloat = 0.0
        var frame = bgView.frame
        moveY = CGFloat(prewMoveY)
        frame.origin.y += moveY
        frame.size.height -= moveY
        bgView.frame = frame
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.25)
         UIView.setAnimationBeginsFromCurrentState(true)
      
        UIView.commitAnimations()
        
        textField.resignFirstResponder()


    }
    

}
