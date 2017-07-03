//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by Juniort on 2017/7/3.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

extension UIButton {
    /*类方法，
    class func createButton(imageName: String, backgroundImageName: String) -> UIButton{
        let  = UIButton()
        .setBackgroundImage(UIImage(named: imageName), forState:.Normal)
        .setBackgroundImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        .setImage(UIImage(named: backgroundImageName), forState: .Normal)
        .setImage(UIImage(named: backgroundImageName  + "_highlighted"), forState: .Highlighted)
        .sizeToFit()
        return 
    }
    */
    //MARK: 拓展为构造函数
    convenience init(imageName: String, backgroundImageName: String){
        self.init()
        setImage(UIImage(named: imageName), forState:.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: backgroundImageName  + "_highlighted"), forState: .Highlighted)
        sizeToFit()
    }
    
}