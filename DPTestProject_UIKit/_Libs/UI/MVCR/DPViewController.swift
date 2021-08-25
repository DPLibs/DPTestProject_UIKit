import Foundation
import UIKit

public protocol DPViewControllerInput: AnyObject {}

open class DPViewController: UIViewController, DPViewControllerInput {
    
    // MARK: - Props
    open var _model: DPViewModelInput?
    open var _router: DPViewRouter?
    
    open lazy var notificationObserver: NotificationObserver = .init()
    
    // MARK: - Lifecycle
    public init(
        _model: DPViewModelInput,
        _router: DPViewRouter = DPViewRouter()
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self._model = _model
        
        self._router = _router
        self._router?._viewController = self
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
    open func setupComponets() {}
    
    open func setupStyles() {}
    
    open func setupModel() {}
}
