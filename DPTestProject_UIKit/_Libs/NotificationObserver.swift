//
//  NotificationObserver.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 19.08.2021.
//

import Foundation
import Combine

open class NotificationObserver: NSObject {
    
    // MARK: - Static
    public struct Observer {
        public let notificationName: Notification.Name
        public var handler: (Notification) -> Void
        
        public static func notification(_ name: Notification.Name, handler: @escaping (Notification) -> Void) -> Self {
            .init(notificationName: name, handler: handler)
        }
    }
    
    // MARK: - Props
    public let notificationCenter: NotificationCenter
    public private(set) var publisherSinks: [AnyCancellable] = []
    
    // MARK: - Init
    deinit {
        self.notificationCenter.removeObserver(self)
        self.publisherSinks.forEach({ $0.cancel() })
    }
    
    public override init() {
        self.notificationCenter = .default
        
        super.init()
    }
    
    open func observe(_ observers: Observer...) {
        observers.forEach({ observer in
            let publisher = self.notificationCenter
                .publisher(for: observer.notificationName)
                .sink(receiveValue: observer.handler)

            self.publisherSinks += [publisher]
        })
    }
    
}
