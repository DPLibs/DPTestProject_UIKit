import Foundation
import UIKit

// MARK: - Header
open class DPTableSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Model
    open class ViewModel {

        // MARK: - Props
        open var viewIdentifier: String {
            ""
        }

        open var viewHeight: CGFloat {
            UITableView.automaticDimension
        }

        open var viewEstimatedHeight: CGFloat {
            32.0
        }

        // MARK: - Init
        public init() { }
        
    }

    // MARK: - Props
    public var viewModel: ViewModel? {
        didSet {
            self.updateViews()
        }
    }

    // MARK: - Init
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.setupViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupViews()
    }

    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.setupViews()
    }

    open func setupViews() { }

    open func updateViews() { }

    @objc
    open func tapButtonHandler(_ button: UIButton) { }

    @objc
    open func tapGestureHandler(_ gesture: UITapGestureRecognizer) { }
    
}
