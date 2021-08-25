import Foundation
import UIKit

public protocol NavigationControllerInput: AnyObject {}

open class DPNavigationController: UINavigationController, NavigationControllerInput {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    open func setupComponets() {
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension DPNavigationController: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
