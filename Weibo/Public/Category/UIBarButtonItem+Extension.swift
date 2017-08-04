//
//  UIBarButtonItem+Extension.swift
//  Weibo
//
//  Created by Jentle on 2017/8/3.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName:String){
        self.init()
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.customView = btn
    }
}
