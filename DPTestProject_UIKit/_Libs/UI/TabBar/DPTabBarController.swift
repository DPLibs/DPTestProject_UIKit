import Foundation
import UIKit

public protocol TabBarControllerInput: AnyObject {
    var selectedIndex: Int { get set }
    var selectedItem: TabBarItem? { get set }
}
 
open class DPTabBarController: UITabBarController, TabBarControllerInput {
    
    // MARK: - Props
    open var items: [TabBarItem] = []
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    open var selectedItem: TabBarItem? {
        get {
            self.items.first(where: { $0.tag == self.selectedIndex })
        }
        set {
            guard let tag = newValue?.tag, self.items.contains(where: { $0.tag == tag }) else { return }
            
            self.selectedIndex = tag
        }
    }
    
    open func setupComponets() { }
}
