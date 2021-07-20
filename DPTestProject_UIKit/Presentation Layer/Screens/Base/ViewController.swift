import Foundation
import UIKit

public protocol ViewControllerInput: AnyObject { }

open class ViewController<ViewModel: ViewModelInput>: UIViewController, ViewControllerInput {
    
    // MARK: - Props
    open var model: ViewModel? {
        didSet {
            self.setupModel()
        }
    }
    
    // MARK: - Lifecycle
    public init(model: ViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.model = model
        self.model?.output = self as? ViewModelOutput
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
        self.setupModel()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupStyles()
    }
    
    // MARK: - Methods
    open func setupComponets() { }
    
    open func setupStyles() { }
    
    open func setupModel() { }
}
