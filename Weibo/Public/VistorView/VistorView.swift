//
//  VistorView.swift
//  Weibo
//
//  Created by Juniort on 2017/7/6.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

class VistorView: UIView {
    
    class func xibView() -> VistorView{
        
        return NSBundle.mainBundle().loadNibNamed("VistorView",owner: nil, options:nil).last as! VistorView
    }

}
