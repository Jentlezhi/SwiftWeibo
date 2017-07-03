//
//  MainTabBarViewController.swift
//  Weibo
//
//  Created by Juniort on 2017/6/6.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private lazy var composeButton : UIButton = {
        let customBtn = UIButton()
        customBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState:.Normal)
        customBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        customBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        customBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        customBtn.sizeToFit()
        return customBtn;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeButton.center = CGPointMake(tabBar.center.x, tabBar.bounds.size.height*0.5)
        tabBar.addSubview(composeButton)
        
    }
    
    //item防止被系统方法覆盖，所以不能在viewDidLoad方法中
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        adjsutItems()
//    }

}

extension MainTabBarViewController {
   private func adjsutItems(){
        let item = tabBar.items![2]
        item.enabled = false
    }
}














//MARK: - JSON解析，动态加载控制器
extension MainTabBarViewController {
    private func jsonSerialization(){
        guard let jsonPath = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil) else {
            return
        }
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            return
        }
        
        guard let anyObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) else{
            return
        }
        guard let dictArray = anyObject as? [[String : AnyObject]] else{
            return
        }
        for dict in dictArray {
            guard let vcName = dict["vcName"] as? String else{
                continue
            }
            guard let title = dict["title"] as? String else{
                continue
            }
            guard let imageName = dict["imageName"] as? String else{
                continue
            }
            
            let selectedImageName = imageName + "_highlighted"
            
            addChildViewController(vcName, title: title, normalImageName: imageName, selectedImageName: selectedImageName)
            
        }
    }

}
//MARK: - 字符串创建控制器
extension MainTabBarViewController{
    private func addChildViewController(childControllerName: String, title: String,normalImageName: String, selectedImageName: String) {
        
        guard let nameSpace =  NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else{
            return
        }
        
        guard let className = NSClassFromString(nameSpace + "." + childControllerName) else{
            return
        }
        
        guard let childViewControllerType = className as? UIViewController.Type else{
            return
        }
        let childViewController = childViewControllerType.init()
        
        childViewController.title = title
        childViewController.tabBarItem.image = UIImage(named: normalImageName)
        childViewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        let nav = UINavigationController(rootViewController: childViewController)
        addChildViewController(nav)
    }
}
//MARK:- 添加子控制器
extension MainTabBarViewController {
    private func createTabBarViewControllers(){
    addChildViewController("HomeViewController", title: "主页", normalImageName:"tabbar_home", selectedImageName: "tabbar_home_highlighted")
    addChildViewController("MessageViewController", title: "消息", normalImageName:"tabbar_message_center", selectedImageName: "tabbar_message_center_highlighted")
    addChildViewController("FoundViewController", title: "发现", normalImageName:"tabbar_discover", selectedImageName: "tabbar_discover_highlighted")
    addChildViewController("MeViewController", title: "我", normalImageName:"tabbar_profile", selectedImageName: "tabbar_profile_highlighted")
    }
}
