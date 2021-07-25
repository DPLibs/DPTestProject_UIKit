import Foundation
import UIKit

public protocol ViewControllerInput: AnyObject { }

open class ViewController: UIViewController, ViewControllerInput {
    
    // MARK: - Props
    open var _model: ViewModelInput?
    open var _router: ViewRouter?
    
    // MARK: - Lifecycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public init(_model: ViewModelInput) {
        super.init(nibName: nil, bundle: nil)
        
        self._model = _model
        self._router = ViewRouter()
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
    open func setupComponets() { }
    
    open func setupStyles() { }
    
    open func setupModel() {
        self._model?._output = self as? ViewModelOutput
    }
    
    open func subscribeToNotifications(_ notifications: [Notification.Name]) {
        notifications.forEach({
            NotificationCenter.default.addObserver(self, selector: #selector(self.provideNotification(_:)), name: $0, object: nil)
        })
    }
    
    @objc
    open func provideNotification(_ notification: Notification) {}
}
