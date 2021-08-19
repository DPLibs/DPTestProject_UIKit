//
//  NotificationObserver.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 19.08.2021.
//

import Foundation

open class NotificationObserver: NSObject {
    
    // MARK: - Props
    open private(set) var observeHandler: ((Notification) -> Void)?
    
    public let notificationCenter: NotificationCenter
    
    // MARK: - Init
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.notificationCenter.removeObserver(self)
    }
    
    public override init() {
        self.notificationCenter = .default
        
        super.init()
    }
    
    open func observe(_ notifications: [Notification.Name], handler: ((Notification) -> Void)?) {
        self.observeHandler = handler
        
        notifications.forEach({
            self.notificationCenter.addObserver(self, selector: #selector(self.provideNotification(_:)), name: $0, object: nil)
        })
    }
    
    @objc
    open func provideNotification(_ notification: Notification) {
        self.observeHandler?(notification)
    }
    
}
