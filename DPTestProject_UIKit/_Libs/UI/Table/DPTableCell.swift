import Foundation
import UIKit

// MARK: - Cell
open class DPTableCell: UITableViewCell {
    
    // MARK: - Model
    open class ViewModel {
        
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
        
//        open var identifier: String = ""
//
//        // MARK: - Methods
//        open func createLeadingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? { .empty }
//
//        open func createTrailingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? { .empty }
//
//        open func createEditActions(for cell: UITableViewCell) -> [UITableViewRowAction]? { [] }
//
//        open func willBeginEditing(for cell: UITableViewCell) { }
//
//        open func didEndEditing(for cell: UITableViewCell) { }
        
        
        ////// MARK: - Equatable
        ////extension TableCellModel: Equatable {
        ////
        ////    public static func == (lhs: TableCellModel, rhs: TableCellModel) -> Bool {
        ////        guard !lhs.identifier.isEmpty, !rhs.identifier.isEmpty else { return false }
        ////
        ////        return lhs.identifier == rhs.identifier
        ////    }
        ////
        ////}
    }
    
    // MARK: - Props
    open var viewModel: ViewModel? {
        didSet {
            self.updateViews()
        }
    }

    // MARK: - Init
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

    override open func setHighlighted(_ highlighted: Bool, animated: Bool) { }

    override open func setSelected(_ selected: Bool, animated: Bool) {
//        self.viewModel?.didTap?()
    }

    open func setupViews() {
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction(_:))))
    }

    open func updateViews() { }

    @objc
    open func tapButtonAction(_ button: UIButton) { }

    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {
        if gesture.view == self.contentView {
            self.viewModel?.didTap?()
        }
    }
    
}

