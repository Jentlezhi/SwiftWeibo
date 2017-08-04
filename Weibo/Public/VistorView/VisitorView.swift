//
//  VisitorView.swift
//  Weibo
//
//  Created by Juniort on 2017/7/6.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    class func xibView() -> VisitorView{
        
        return Bundle.main.loadNibNamed("VisitorView",owner: nil, options:nil)!.last as! VisitorView
    }
    
    //MARK:控件的属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    func setupVisitViewInfo(_ iconName: String,title: String){
        iconView.image = UIImage(named: iconName)
        rotationView.isHidden = true
        tipLabel.text = title
    }
    
    //MARK:旋转动画
    func addRotationAnimation(){
        let keyFrame = CABasicAnimation(keyPath:"transform.rotation.z")
        keyFrame.fromValue = 0
        keyFrame.toValue = Double.pi*2
        keyFrame.repeatCount = MAXFLOAT
        keyFrame.duration = 4.5
        keyFrame.isRemovedOnCompletion = false
        rotationView.layer.add(keyFrame, forKey: nil)
    }
    
}
