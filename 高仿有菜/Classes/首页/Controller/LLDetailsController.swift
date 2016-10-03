//
//  LLDetailsController.swift
//  单糖
//
//  Created by JYD on 16/8/16.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class LLDetailsController: LLBaseViewController {
    var detailUrl:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        let tabBarVc = self.tabBarController as?LLTabBarController
        
        tabBarVc?.customTabBar.isHidden = true
    }
          // MARK: ---- 添加 UI 视图
    
    private func setupUI() {
    
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo((self.view)!)
        }
        
        if let detaiString = detailUrl {
            let url = NSURL(string:detaiString)
            let request = NSURLRequest(url: url! as URL)
            webView.load(request as URLRequest)

        }

       }
    
      // MARK: ---- 懒加载
    
    private lazy var webView:WKWebView = {
        
        let web = WKWebView()
        web.backgroundColor = UIColor.clear
        web.uiDelegate = self
        web.navigationDelegate = self
        web.isUserInteractionEnabled = true
        return web
    
    }()
    
    

}

extension LLDetailsController:WKUIDelegate ,WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show(withStatus: "拼命加载中...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.showError(withStatus: "加载失败....")
    }
    /**
     WKWebView 点击链接无反应
     */
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if (navigationAction.targetFrame?.isMainFrame != true) {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
    private func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.targetFrame == nil {
            
            print("跳转的是一个新页面")
            
        
            webView.load(navigationAction.request)
        }else {
       
        }
        decisionHandler(.allow)
        
    }

}
