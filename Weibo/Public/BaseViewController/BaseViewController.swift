//
//  BaseViewController.swift
//  Weibo
//
//  Created by Juniort on 2017/7/5.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: 懒加载访客视图
    lazy var vistorView : VisitorView = VisitorView.xibView()
    //MARK: 懒加载访客视图
    let login = true
    
    override func viewDidLoad() {
        
        login ? super.viewDidLoad():loadVistorView()
        setNavBarItems()
    }
}

//MARK: 设置UI界面
extension BaseViewController{
    
    fileprivate func loadVistorView(){
      view = vistorView
        vistorView.registerBtn.addTarget(self, action:#selector(registerAction), for: .touchUpInside)
        vistorView.loginBtn.addTarget(self, action:#selector(loginAction), for: .touchUpInside)
    }
    
    fileprivate func setNavBarItems(){
        let textAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 13)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action:#selector(registerAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action:#selector(loginAction))
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(textAttributes, for:UIControlState())
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes, for:UIControlState())
    }
}

//MARK: 按钮点击
extension BaseViewController{
    @objc fileprivate func registerAction(){
        WBLog(registerAction)
    }
    @objc fileprivate func loginAction(){
        WBLog(loginAction)
    }
}
