import Foundation
import UIKit

open class DPTableRow {
    
    // MARK: - Props
    open var cellIdentifier: String? {
        nil
    }

    open var cellHeight: CGFloat {
        UITableView.automaticDimension
    }
    
    open var cellEstimatedHeight: CGFloat {
        50
    }
    
    public var didTap: (() -> Void)?

    // MARK: - Init
    public init(didTap: (() -> Void)? = nil) {
        self.didTap = didTap
    }
//        open func createLeadingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? { .empty }
//        open func createTrailingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? { .empty }
//        open func createEditActions(for cell: UITableViewCell) -> [UITableViewRowAction]? { [] }
//        open func willBeginEditing(for cell: UITableViewCell) { }
//        open func didEndEditing(for cell: UITableViewCell) { }
}

// MARK: - Cell
open class DPTableRowView<ViewModel: DPTableRow>: DPTableViewCell {
    
    // MARK: - Props
    open var viewModel: ViewModel? {
        get {
            self.model as? ViewModel
        }
        set {
            self.model = newValue
        }
    }
    
    // MARK: - Methods
    open override func setupViews() {
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction(_:))))
    }

    @objc
    open override func tapGestureAction(_ gesture: UITapGestureRecognizer) {
        if gesture.view == self.contentView {
            self.viewModel?.didTap?()
        }
    }
    
}
