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
        
        return NSBundle.mainBundle().loadNibNamed("VisitorView",owner: nil, options:nil).last as! VistorView
    }
    
    //MARK:控件的属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    
    func setupVisit
    

}
