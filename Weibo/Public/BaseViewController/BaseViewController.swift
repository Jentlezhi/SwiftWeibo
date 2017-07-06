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
    lazy var vistorView : VistorView = VistorView.xibView()
    //MARK: 懒加载访客视图
    let login = false
    
    override func viewDidLoad() {
        
        login ? super.viewDidLoad():loadVistorView()
    }
}


extension BaseViewController{
    
    private func loadVistorView(){
      view = vistorView
    }
}