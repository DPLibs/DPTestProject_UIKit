//
//  AppTheme.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 11.08.2021.
//

import Foundation
import UIKit

public extension AppTheme {
    
    var mainBackgroundColor: UIColor {
        switch self.style {
        case .light:
            return.white
        case .dark:
            return .black
        default:
            return .white
        }
    }
    
    var mainTextColor: UIColor {
        switch self.style {
        case .light:
            return.black
        case .dark:
            return .white
        default:
            return .black
        }
    }
    
}
