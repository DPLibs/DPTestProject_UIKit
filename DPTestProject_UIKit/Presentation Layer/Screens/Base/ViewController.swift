import Foundation
import UIKit

public protocol ViewControllerInput: AnyObject { }

open class ViewController: UIViewController, ViewControllerInput {
    
    // MARK: - Props
    open var _model: ViewModelInput? {
        didSet {
            self.setupModel()
        }
    }
    
    // MARK: - Lifecycle
    public init(_model: ViewModelInput) {
        super.init(nibName: nil, bundle: nil)
        
        self._model = _model
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
