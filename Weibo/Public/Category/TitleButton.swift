//
//  TitleButton.swift
//  Weibo
//
//  Created by Jentle on 2017/8/6.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        adjustsImageWhenHighlighted = false
        sizeToFit()
    }
    //MARK:swift中规定：重写控件的init(frame)方法或者init()方法，必须重写init?(coder aDecoder: NSCoder)方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0;
        imageView!.frame.origin.x = titleLabel!.frame.width + 5
    }

}
