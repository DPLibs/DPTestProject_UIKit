import Foundation
import UIKit

// MARK: - Model
open class DPTableSectionHeader {

    // MARK: - Props
    open var viewIdentifier: String? {
        nil
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

// MARK: - View
open class DPTableSectionHeaderView<ViewModel: DPTableSectionHeader>: DPTableViewHeaderFooterView {
    
    // MARK: - Props
    open var viewModel: ViewModel? {
        didSet {
            self.updateViews()
        }
    }

    open override func setupModel(_ model: Any?) {
        self.viewModel = model as? ViewModel
    }
    
}
