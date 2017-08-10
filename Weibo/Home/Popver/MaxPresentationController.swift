//
//  MaxPresentationController.swift
//  Weibo
//
//  Created by Jentle on 2017/8/10.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

class MaxPresentationController: UIPresentationController {
    fileprivate lazy var maskView : UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        let presentedViewW : CGFloat = 150.0
        presentedView?.frame = CGRect(x: (UIScreen.main.bounds.size.width - presentedViewW)*0.5, y: 64.0 - 20.0, width: presentedViewW, height: 200)
        setMaskView()
    }
}

//MARK:设置界面
extension MaxPresentationController{
    func setMaskView(){
      containerView?.insertSubview(maskView, belowSubview:presentedView!)
      maskView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
      maskView.frame = containerView?.bounds ?? CGRect.zero
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        maskView.addGestureRecognizer(tap)
    }
}

extension MaxPresentationController{
    @objc fileprivate func dismissAction(){
       presentedViewController.dismiss(animated: true, completion: nil)
    }
}
