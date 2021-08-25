////
////  UITableView+Extensions.swift
////  DPDataSource
////
////  Created by Дмитрий Поляков on 12.04.2021.
////
//
//import Foundation
//import UIKit
//
//#warning("DP: Append to DP")
//public extension String {
//    
//    static func className(_ aClass: AnyClass) -> String {
//        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
//    }
//    
//}
//
//public extension UIView {
//    
//    class var identifier: String {
//        return String.className(self)
//    }
//    
//}
//
//public extension UITableView {
//    
//    func registerCellClasses(_ cellClasses: [AnyClass]) {
//        cellClasses.forEach({ cellClass in
//            let identifier = String.className(cellClass)
//            
//            self.register(cellClass, forCellReuseIdentifier: identifier)
//        })
//    }
//    
//    func registerCellNibs(_ cellClasses: [AnyClass]) {
//        cellClasses.forEach({ cellClass in
//            let identifier = String.className(cellClass)
//            let nib = UINib(nibName: identifier, bundle: nil)
//            
//            self.register(nib, forCellReuseIdentifier: identifier)
//        })
//    }
//    
//    func registerHeaderFooterViewClasses(_ viewClasses: [AnyClass]) {
//        viewClasses.forEach({ viewClass in
//            let identifier = String.className(viewClass)
//            
//            self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
//        })
//    }
//    
//    func registerHeaderFooterViewNibs(_ viewClasses: [AnyClass]) {
//        viewClasses.forEach({ viewClass in
//            let identifier = String.className(viewClass)
//            let nib = UINib(nibName: identifier, bundle: nil)
//            
//            self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
//        })
//    }
//    
//}
