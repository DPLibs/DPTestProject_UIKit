import Foundation
import UIKit

open class DPTableView: UITableView {
    
    // MARK: - Props
    open override var refreshControl: UIRefreshControl? {
        didSet {
            self.didSetRefreshControl()
        }
    }
    
    //    open override var contentOffset: CGPoint {
    //        didSet {
    //            self.bottomOffset = self.calculateBottomOffset()
    //        }
    //    }
    
    open var adapter: DPTableAdapter? {
        didSet {
            self.dataSource = self.adapter
            self.delegate = self.adapter
            self.adapter?.tableView = self
        }
    }
    
    //    open var emptyPlaceholder: UIView? {
    //        didSet {
    //            self.didSetEmptyPlaceholder()
    //        }
    //    }
    
    //    open var autoEmptyPlaceholderEnabled: Bool = true
    
    //    open var bottomOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    // MARK: - Init
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    // MARK: - Methods
    open func setupViews() {}
    
    open func didSetRefreshControl() {
        guard let refreshControl = self.refreshControl else { return }

        refreshControl.addTarget(self, action: #selector(self.refreshControlValueChanged(_:)), for: .valueChanged)
        self.bringSubviewToFront(refreshControl)
    }
    
    @objc
    open func refreshControlValueChanged(_ refreshControl: UIRefreshControl) {
//        self.dataOutput?.beginRefreshing(table: self)
    }
    
    open func beginRefreshing() {
        self.refreshControl?.sendActions(for: .valueChanged)

//        self.sections.removeAll()
        self.reloadData()
    }

    open func endRefreshing() {
        self.refreshControl?.endRefreshing()
//        self.dataOutput?.endRefreshing(table: self)
    }
    
    //    // MARK: - Empty Placeholder
    //    open func didSetEmptyPlaceholder() {
    //        print("!!! didSetEmptyPlaceholder")
    //    }
    
    //    open func calculateBottomOffset() -> CGPoint {
    //        let y =
    //            self.contentSize.height -
    //            self.frame.size.height +
    //            self.contentInset.top +
    //            self.contentInset.bottom
    //
    //        return .init(x: 0, y: y)
    //    }
    
}

//open class Table: UITableView, TableInput {
//    open internal(set) var lastContentOffset: CGPoint?
//
//    public var indexPathOfFirstRow: IndexPath? {
//        guard !self.sections.isEmpty, self.sections.first?.rows.isEmpty == false else { return nil }
//
//        return .init(row: .zero, section: .zero)
//    }
//
//    public var indexPathOfLastRow: IndexPath? {
//        guard !self.sections.isEmpty, self.sections.first?.rows.isEmpty == false else { return nil }
//
//        return .init(row: (self.sections.last?.rows.endIndex ?? 1) - 1, section: self.sections.endIndex - 1)
//    }
//
//    open func calculateRowsCountOrLess(at indexPath: IndexPath) -> Int {
//        return self.sections
//            .prefix(indexPath.section + 1)
//            .enumerated()
//            .reduce(0, { sum, item in
//                let section = item.element
//                let sectionIndex = item.offset
//
//                let rowsPrefix = sectionIndex == indexPath.section ?
//                    indexPath.row + 1 :
//                    section.rows.count
//
//                return sum + section.rows.prefix(rowsPrefix).count
//            })
//    }
//

//}
