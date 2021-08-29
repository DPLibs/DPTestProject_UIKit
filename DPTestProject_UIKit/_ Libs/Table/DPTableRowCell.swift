import Foundation
import UIKit

open class DPTableRowCell<RowModel: DPTableRowModel>: DPTableViewCell {
    
    // MARK: - Props
    open var viewModel: RowModel? {
        get {
            self.model as? RowModel
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
