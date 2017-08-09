//
//  HomeViewController.swift
//  Weibo
//
//  Created by Juniort on 2017/6/6.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

class HomeViewController: BaseViewController {

    // MARK:懒加载属性
    fileprivate lazy var titleView : TitleButton = TitleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vistorView.addRotationAnimation()
        if !login {
            return
        }
        setupNavigationBar()
    }
}

extension HomeViewController{
    fileprivate func setupNavigationBar(){
        /* 抽出类拓展
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "navigationbar_friendattention"), for: .normal)
        leftBtn.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), for: .highlighted)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "navigationbar_pop"), for: .normal)
        rightBtn.setImage(UIImage(named: "navigationbar_pop_highlighted"), for: .highlighted)
        rightBtn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        */
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        titleView.setTitle("Jentle", for: .normal)
        titleView.addTarget(self, action: #selector(titleButtonClick as (TitleButton)->()), for: .touchUpInside)
        navigationItem.titleView = titleView
    }
}

//MARK: 事件监听点击
extension HomeViewController{
    @objc fileprivate func titleButtonClick(titleButton:TitleButton){
        titleButton.isSelected = !titleButton.isSelected
    }

}

//MARK: try-catch demo
extension HomeViewController{
    fileprivate func tryCatchDemo(){
        do {
            let printerResponse = try send( 1440, toPrinter: "On")
            print(printerResponse)
        } catch PrinterError.onFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }
    }
}


extension HomeViewController{
    func send(_ job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }else if printerName == "OnFire" {
            throw PrinterError.onFire
        }else if printerName == "On" {
            throw PrinterError.outOfPaper
        }
        return "Job sent"
    }
}
