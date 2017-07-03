//
//  HomeViewController.swift
//  Weibo
//
//  Created by Juniort on 2017/6/6.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

enum PrinterError: ErrorType {
    case OutOfPaper
    case NoToner
    case OnFire
}

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let printerResponse = try send( 1440, toPrinter: "On")
            print(printerResponse)
        } catch PrinterError.OnFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }
    }


}

extension HomeViewController{
    
    func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.NoToner
        }else if printerName == "OnFire" {
            throw PrinterError.OnFire
        }else if printerName == "On" {
            throw PrinterError.OutOfPaper
        }
        return "Job sent"
    }
}
