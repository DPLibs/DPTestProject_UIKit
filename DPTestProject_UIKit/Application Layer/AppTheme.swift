//
//  AppTheme.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 25.07.2021.
//

import Foundation
import UIKit

public struct AppTheme {
    
    public struct Style: Equatable {
        public let rawValue: String
        
        public static let light: Self = .init(rawValue: "light")
        public static let dark: Self = .init(rawValue: "dark")
        
        public static var system: Self {
            switch UIScreen.main.traitCollection.userInterfaceStyle {
            case .dark:
                return .dark
            case .light:
                return .light
            case .unspecified:
                return .light
            @unknown default:
                return .light
            }
        }
        
        static let didSetCurrent: Notification.Name = .init("AppTheme.didSetCurrent")
        
        public static var useSystemStyle: Bool {
            get {
                if UserDefaults.standard.value(forKey: "useSystemStyle") == nil {
                    UserDefaults.standard.setValue(true, forKey: "useSystemStyle")
                }
                
                return UserDefaults.standard.bool(forKey: "useSystemStyle")
            }
            set {
                UserDefaults.standard.setValue(newValue, forKey: "useSystemStyle")
                
                if newValue {
                    Style.current = .system
                }
            }
        }
        
        public static var current: Self {
            get {
                guard !Style.useSystemStyle else { return .system }
                
                if let rawValue = UserDefaults.standard.string(forKey: "current") {
                    return .init(rawValue: rawValue)
                } else {
                    let style = Style.system
                    UserDefaults.standard.setValue(style.rawValue, forKey: "current")
                    
                    return style
                }
            }
            set {
                print("!!!", newValue, Style.useSystemStyle)
                if Style.useSystemStyle {
                    UserDefaults.standard.setValue(Style.system.rawValue, forKey: "current")
                } else {
                    UserDefaults.standard.setValue(newValue.rawValue, forKey: "current")
                }
                
                NotificationCenter.default.post(name: Style.didSetCurrent, object: nil)
            }
        }
    }
    
    public let style: Style
    
    public static let current: Self = .init(style: .current)
    
}

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
