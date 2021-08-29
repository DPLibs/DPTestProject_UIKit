import Foundation
import UIKit

// MARK: - Data Output
public protocol TableDataOutput: AnyObject {
    func beginRefreshing(_ tableView: DPTableView)
    func endRefreshing(_ tableView: DPTableView)
    func selectRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell, row: DPTableRow)
    func scrollToPosition(_ tableView: DPTableView, position: UITableView.ScrollPosition, rowsOffset: Int)
    func topAchived(_ tableView: DPTableView)
    func bottomAchived(_ tableView: DPTableView)
}

public extension TableDataOutput {
    func beginRefreshing(_ tableView: DPTableView) {}
    func endRefreshing(_ tableView: DPTableView) {}
    func selectRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell, row: DPTableRow) {}
    func scrollToPosition(_ tableView: DPTableView, position: UITableView.ScrollPosition, rowsOffset: Int) {}
    func topAchived(_ tableView: DPTableView) {}
    func bottomAchived(_ tableView: DPTableView) {}
}

// MARK: - Cells Output
public protocol TableCellsOutput: AnyObject {
    func cellForRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell)
    func willDisplayRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell)
}

public extension TableCellsOutput {
    func cellForRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell) {}
    func willDisplayRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell) {}
}

// MARK: - Scroll Output
public protocol TableScrollOutput: AnyObject {
    func didScroll(_ tableView: DPTableView, to position: UITableView.ScrollPosition, isDragging: Bool)
    func scrollPositionAchived(_ tableView: DPTableView, position: UITableView.ScrollPosition, isAchived: Bool)
}

public extension TableScrollOutput {
    func didScroll(_ tableView: DPTableView, to position: UITableView.ScrollPosition, isDragging: Bool) {}
    func scrollPositionAchived(_ tableView: DPTableView, position: UITableView.ScrollPosition, isAchived: Bool) {}
}

// MARK: - View
open class DPTableView: UITableView {
    
    // MARK: - Props
    open override var refreshControl: UIRefreshControl? {
        didSet {
            self.didSetRefreshControl()
        }
    }
    
    open weak var dataOutput: TableDataOutput?
    
    open weak var cellsOutput: TableCellsOutput?
    
    open weak var scrollOutput: TableScrollOutput?
    
    open var dataSourceAdapter: DPTableDataSourceAdapter? {
        didSet {
            self.didSetDataSourceAdapter()
        }
    }
    
    open var delegateAdapter: DPTableDelegateAdapter? {
        didSet {
            self.didSetDelegateAdapter()
        }
    }
    
    open var sections: [DPTableSection] = [] {
        didSet {
            self.updatePlaceholderViewAutoHidden()
        }
    }
    
    open var placeholderView: DPPlaceholderView? {
        didSet {
            oldValue?.removeFromSuperview()
            self.backgroundView = self.placeholderView
        }
    }
    
    open var placeholderViewAutoHiddenEnabled: Bool = true
    
    // MARK: - Init
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.setupComponets()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupComponets()
    }
    
    // MARK: - Methods
    open func setupComponets() {
        self.delegateAdapter = .init()
        self.dataSourceAdapter = .init()
    }
    
    open func reloadData(with sections: [DPTableSection]) {
        self.sections = sections
        self.reloadData()
    }
    
    open func didSetDataSourceAdapter() {
        self.dataSourceAdapter?.tableView = self
    }
    
    open func didSetDelegateAdapter() {
        self.delegateAdapter?.tableView = self
    }
    
    open func didSetRefreshControl() {
        guard let refreshControl = self.refreshControl else { return }

        refreshControl.addTarget(self, action: #selector(self.refreshControlValueChanged(_:)), for: .valueChanged)
        self.bringSubviewToFront(refreshControl)
    }
    
    @objc
    open func refreshControlValueChanged(_ refreshControl: UIRefreshControl) {
        self.dataOutput?.beginRefreshing(self)
    }
    
    open func beginRefreshing() {
        self.refreshControl?.sendActions(for: .valueChanged)
        self.reloadData()
    }

    open func endRefreshing() {
        self.refreshControl?.endRefreshing()
        self.dataOutput?.endRefreshing(self)
    }
    
    open func updatePlaceholderViewAutoHidden() {
        guard self.placeholderViewAutoHiddenEnabled else { return }
        
        var isHidden: Bool {
            self.sections.isEmpty && self.sections.rowsIsEmpty && self.sections.headersIsEmpty && self.sections.footersIsEmpty
        }
        
        self.placeholderView?.setHidden(isHidden, animated: true)
    }

}
