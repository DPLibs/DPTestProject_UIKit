import Foundation
import UIKit

//public protocol TableDataOutput: AnyObject {
//    func beginRefreshing(table: DPTableView)
//    func endRefreshing(table: DPTableView)
//
//    func scrollToPosition(table: DPTableView, position: TableScrollPosition, rowsOffset: Int)
//    func selectRow(table: DPTableView, indexPath: IndexPath, cell: TableCellInput, model: TableCellModelInput)
//}
//
//public protocol TableCellsOutput: AnyObject {
//    func cellForRow(table: DPTableView, indexPath: IndexPath, cell: TableCellInput)
//    func willDisplayRow(table: DPTableView, indexPath: IndexPath, cell: TableCellInput)
//}
//
//public protocol TableScrollOutput: AnyObject {
//    func didScroll(table: DPTableView, to position: TableScrollPosition, isDragging: Bool)
//    func scrollPositionAchived(table: DPTableView, position: TableScrollPosition, isAchived: Bool)
//}

open class DPTableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Props
    open weak var tableView: DPTableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
        }
    }
    
    open var sections: [DPTableSection] {
        get {
            self.tableView?.sections ?? []
        }
        set {
            self.tableView?.sections = newValue
        }
    }
    
    //    open weak var dataOutput: TableDataOutput?
    //    open weak var scrollOutput: TableScrollOutput?
    //    open weak var cellsOutput: TableCellsOutput?
    
    // MARK: - UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return .zero }
        
        return self.sections[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let row = self.sections.getRow(at: indexPath),
            let cellIdentifier = row.cellIdentifier,
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DPTableViewCell
        else { return .init() }

        cell.model = row
        
//        self.cellsOutput?.cellForRow(table: self, indexPath: indexPath, cell: cell)

        return cell
    }
    
    // MARK: - UITableViewDelegate

}

//extension Table: UITableViewDelegate {
//
//    // MARK: - UITableViewDelegate + Row
//    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let cell = cell as? TableCellInput else { return }
//
//        self.cellsOutput?.willDisplayRow(table: self, indexPath: indexPath, cell: cell)
//
//        let offsetToTop = self.calculateRowsCountOrLess(at: indexPath)
//        let offsetToBottom = self.rowsCount - offsetToTop
//
//        self.dataOutput?.scrollToPosition(table: self, position: .top, rowsOffset: offsetToTop)
//        self.dataOutput?.scrollToPosition(table: self, position: .bottom, rowsOffset: offsetToBottom)
//    }
//
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard
//            let cell = tableView.cellForRow(at: indexPath) as? TableCellInput,
//            let model = self.sections.element(at: indexPath.section)?.rows.element(at: indexPath.row)
//        else { return }
//
//        self.dataOutput?.selectRow(table: self, indexPath: indexPath, cell: cell, model: model)
//    }
//
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard
//            let model = self.sections.element(at: indexPath.section)?.rows.element(at: indexPath.row),
//            !model.cellIdentifier.isEmpty
//        else {
//            return UITableView.automaticDimension
//        }
//
//        return model.cellHeight
//    }
//
//    // MARK: - UITableViewDelegate + Scroll
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset
//
//        if self.lastContentOffset == nil {
//            self.lastContentOffset = offset
//        }
//
//        guard let lastOffset = self.lastContentOffset else { return }
//
//        let scrollToPosition: TableScrollPosition = lastOffset.y > offset.y ? .top : .bottom
//        let bottomOffset = self.calculateBottomOffset()
//        let isDragging = scrollView.isDragging
//
//        self.scrollOutput?.didScroll(table: self, to: scrollToPosition, isDragging: isDragging)
//
//        guard isDragging else { return }
//
//        switch scrollToPosition {
//        case .top:
//            let pointForCell = CGPoint(x: offset.x, y: offset.y < 0 ? 0 : offset.y)
//
//            if let indexPathForCell = self.indexPathForRow(at: pointForCell) {
//                let offsetToTop = self.calculateRowsCountOrLess(at: indexPathForCell)
//                self.dataOutput?.scrollToPosition(table: self, position: .top, rowsOffset: offsetToTop)
//            }
//        case .bottom:
//            let pointForCell = CGPoint(x: offset.x, y: offset.y + self.frame.height)
//
//            if let indexPathForCell = self.indexPathForRow(at: pointForCell) {
//                let offsetToBottom = self.rowsCount - self.calculateRowsCountOrLess(at: indexPathForCell)
//                self.dataOutput?.scrollToPosition(table: self, position: .bottom, rowsOffset: offsetToBottom)
//            }
//        }
//
//        let topAchived = offset.y <= -scrollView.contentInset.top
//        let bottomAchived = offset.y >= (bottomOffset.y < 0 ? 0 : bottomOffset.y)
//
//        self.scrollOutput?.scrollPositionAchived(table: self, position: .top, isAchived: topAchived)
//        self.scrollOutput?.scrollPositionAchived(table: self, position: .bottom, isAchived: bottomAchived)
//
//        self.lastContentOffset = offset
//    }
//
//    // MARK: - UITableViewDelegate + Header In Section
//    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard
//            let model = self.sections.element(at: section)?.header,
//            !model.viewIdentifier.isEmpty,
//            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: model.viewIdentifier) as? TableSectionHeaderView
//        else {
//            return nil
//        }
//
//        view.model = model
//        return view
//    }
//
//    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        guard
//            let model = self.sections.element(at: section)?.header,
//            !model.viewIdentifier.isEmpty
//        else {
//            return .zero
//        }
//
//        return model.viewHeight
//    }
//
//    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        guard
//            let model = self.sections.element(at: section)?.header,
//            !model.viewIdentifier.isEmpty
//        else {
//            return .zero
//        }
//
//        return model.viewEstimatedHeight
//    }
//
//    // MARK: - UITableViewDelegate + Footer In Section
//    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard
//            let model = self.sections.element(at: section)?.footer,
//            !model.viewIdentifier.isEmpty,
//            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: model.viewIdentifier) as? TableSectionHeaderView
//        else {
//            return nil
//        }
//
//        view.model = model
//        return view
//    }
//
//    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        guard
//            let model = self.sections.element(at: section)?.footer,
//            !model.viewIdentifier.isEmpty
//        else {
//            return .zero
//        }
//
//        return model.viewHeight
//    }
//
//    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        guard
//            let model = self.sections.element(at: section)?.footer,
//            !model.viewIdentifier.isEmpty
//        else {
//            return .zero
//        }
//
//        return model.viewEstimatedHeight
//    }
//
//    // MARK: - UITableViewDelegate + Swipe
//    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard
//            let model = self.sections.element(at: indexPath.section)?.rows.element(at: indexPath.row),
//            !model.cellIdentifier.isEmpty,
//            let cell = tableView.cellForRow(at: indexPath)
//        else {
//            return .empty
//        }
//
//        return model.createLeadingSwipeActionsConfiguration(for: cell)
//    }
//
//    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard
//            let model = self.sections.element(at: indexPath.section)?.rows.element(at: indexPath.row),
//            !model.cellIdentifier.isEmpty,
//            let cell = tableView.cellForRow(at: indexPath)
//        else {
//            return .empty
//        }
//
//        return model.createTrailingSwipeActionsConfiguration(for: cell)
//    }
//
//    // MARK: - UITableViewDelegate + Edit
//    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        guard
//            let model = self.sections.element(at: indexPath.section)?.rows.element(at: indexPath.row),
//            !model.cellIdentifier.isEmpty,
//            let cell = tableView.cellForRow(at: indexPath)
//        else {
//            return nil
//        }
//
//        return model.createEditActions(for: cell)
//    }
//
//    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//        guard
//            let model = self.sections.element(at: indexPath.section)?.rows.element(at: indexPath.row),
//            !model.cellIdentifier.isEmpty,
//            let cell = tableView.cellForRow(at: indexPath)
//        else { return }
//
//        return model.willBeginEditing(for: cell)
//    }
//
//    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        guard
//            let indexPath = indexPath,
//            let model = self.sections.element(at: indexPath.section)?.rows.element(at: indexPath.row),
//            !model.cellIdentifier.isEmpty,
//            let cell = tableView.cellForRow(at: indexPath)
//        else { return }
//
//        return model.didEndEditing(for: cell)
//    }
//
//}

//
//    // MARK: - Data
//    open func reloadData(_ sections: [TableSectionModelInput]) {
//        self.sections = sections
//        self.reloadData()
//    }
//

//    // MARK: - TableUpdateAction
//    open func beginTableUpdateActions(_ actions: Table.TableUpdateAction..., completion: ((Bool) -> Void)?) {
//        let updaters: [Updater?] = actions.map({ action in
//            switch action.type {
//
//            case .insertSectionsAtIndexSet,
//                 .insertSectionsAtSections,
//                 .insertSectionsAtStart,
//                 .insertSectionsAtEnd:
//                return self.prepareInsertSectionsUpdater(for: action)
//
//            case .deleteSectionsAtIndexSet,
//                 .deleteSectionsAtSections,
//                 .deleteSectionsAtStart,
//                 .deleteSectionsAtEnd:
//                return self.prepareDeleteSectionsUpdater(for: action)
//
//            case .reloadSectionsAtIndexSet,
//                 .reloadSectionsAtSections,
//                 .reloadSectionsAtStart,
//                 .reloadSectionsAtEnd:
//                return self.prepareReloadSectionsUpdater(for: action)
//
//            case .insertRowsAtIndexPaths,
//                 .insertRowsAtRows,
//                 .insertRowsAtStart,
//                 .insertRowsAtEnd:
//                return self.prepareInsertRowsUpdater(for: action)
//
//            case .deleteRowsAtIndexPaths,
//                 .deleteRowsAtRows,
//                 .deleteRowsAtStart,
//                 .deleteRowsAtEnd:
//                return self.prepareDeleteRowsUpdater(for: action)
//
//            case .reloadRowsAtIndexPaths,
//                 .reloadRowsAtRows,
//                 .reloadRowsAtStart,
//                 .reloadRowsAtEnd:
//                return self.prepareReloadRowsUpdater(for: action)
//            }
//        })
//
//        let updatersFilterd = updaters.filter({ $0 != nil }) as? [Updater] ?? []
//
//        self.performUpdaters(
//            updatersFilterd,
//            completion: completion
//        )
//    }
//
//    // MARK: - TableUpdateAction - For Sections
//    open func prepareInsertSectionsUpdater(for action: TableUpdateAction) -> UITableView.Updater? {
//        let animation = action.animation
//        var data: (indexSet: IndexSet, models: [TableSectionModelInput])?
//
//        switch action.type {
//
//        case let .insertSectionsAtIndexSet(indexSet, models):
//            data = (indexSet, models)
//
//        case let .insertSectionsAtSections(sections, models):
//            let indices = sections.map({ section in
//                self.sections.firstIndex(where: { $0.isEqualIdentifier(to: section) })
//            }) as? [Int] ?? []
//
//            let indexSet = IndexSet(indices)
//
//            data = (indexSet, models)
//
//        case let .insertSectionsAtStart(models):
//            let indexSet = IndexSet(models.indices.map({ $0 }))
//
//            data = (indexSet, models)
//
//        case let .insertSectionsAtEnd(models):
//            let offset = self.sections.count
//            let indexSet = IndexSet(models.indices.map({ $0 + offset }))
//
//            data = (indexSet, models)
//
//        default:
//            data = nil
//        }
//
//        guard let indexSet = data?.indexSet, let models = data?.models else { return nil }
//
//        guard indexSet.count == models.count else {
//            fatalError("ERROR: indexSet.count must be equal models count")
//        }
//
//        indexSet.enumerated().forEach({ modelIndex, sectionIndex in
//            self.sections.insert(models[modelIndex], at: sectionIndex)
//        })
//
//        return .insertSections(indexSet, with: animation)
//    }
//
//    open func prepareDeleteSectionsUpdater(for action: TableUpdateAction) -> UITableView.Updater? {
//        let animation = action.animation
//        var data: IndexSet?
//
//        switch action.type {
//
//        case let .deleteSectionsAtIndexSet(indexSet):
//            data = indexSet
//
//        case let .deleteSectionsAtSections(sections):
//            let indices = sections.map({ section in
//                self.sections.firstIndex(where: { $0.identifier == section.identifier })
//            }) as? [Int] ?? []
//
//            data = IndexSet(indices)
//
//        case let .deleteSectionsAtStart(count):
//            let indicies = (0..<count).map({ $0 })
//
//            data = IndexSet(indicies)
//
//        case let .deleteSectionsAtEnd(count):
//            let startIndex = self.sections.count - count >= 0 ? self.sections.count - count : 0
//            let endIndex = self.sections.count
//            let indicies = (startIndex..<endIndex).map({ $0 })
//
//            data = IndexSet(indicies)
//
//        default:
//            data = nil
//        }
//
//        guard let indexSet = data else { return nil }
//
//        guard indexSet.containtsInArrayIndicies(in: self.sections) else {
//            fatalError("ERROR: indexSet must be containts in sections indicies")
//        }
//
//        self.sections.removeAll(at: indexSet.toArray)
//
//        return .deleteSections(indexSet, with: animation)
//    }
//
//    open func prepareReloadSectionsUpdater(for action: TableUpdateAction) -> UITableView.Updater? {
//        let animation = action.animation
//        var data: (indexSet: IndexSet, models: [TableSectionModelInput])?
//
//        switch action.type {
//
//        case let .reloadSectionsAtIndexSet(indexSet, models):
//            data = (indexSet, models)
//
//        case let .reloadSectionsAtSections(sections, models):
//            let indices = sections.map({ section in
//                self.sections.firstIndex(where: { $0.isEqualIdentifier(to: section) })
//            }) as? [Int] ?? []
//
//            let indexSet = IndexSet(indices)
//
//            data = (indexSet, models)
//
//        case let .reloadSectionsAtStart(models):
//            let indexSet = IndexSet(models.indices.map({ $0 }))
//
//            data = (indexSet, models)
//
//        case let .reloadSectionsAtEnd(models):
//            let offset = self.sections.count - models.count
//            let indexSet = IndexSet(models.indices.map({ $0 + offset }))
//
//            data = (indexSet, models)
//
//        default:
//            data = nil
//        }
//
//        guard let indexSet = data?.indexSet, let models = data?.models else { return nil }
//
//        guard indexSet.count == models.count else {
//            fatalError("ERROR: indexSet.count must be equal models count")
//        }
//
//        guard indexSet.containtsInArrayIndicies(in: self.sections) else {
//            fatalError("ERROR: indexSet must be containts in sections indicies")
//        }
//
//        indexSet.enumerated().forEach({ modelIndex, sectionIndex in
//            self.sections[sectionIndex] = models[modelIndex]
//        })
//
//        return .reloadSections(indexSet, with: animation)
//    }
//
//    // MARK: - TableUpdateAction - For Rows
//    open func prepareInsertRowsUpdater(for action: TableUpdateAction) -> UITableView.Updater? {
//        let animation = action.animation
//        var data: (indexPaths: [IndexPath], models: [TableCellModelInput])?
//
//        switch action.type {
//
//        case let .insertRowsAtIndexPaths(indexPaths, models):
//            data = (indexPaths, models)
//
//        case let .insertRowsAtRows(rows, models):
//            var indexPaths: [IndexPath] = []
//
//            rows.forEach({ model in
//                self.sections.enumerated().forEach({ sectionIndex, sectionModel in
//                    guard let rowIndex = sectionModel.rows.firstIndex(where: { $0.isEqualIdentifier(to: model) }) else { return }
//
//                    indexPaths += [.init(row: rowIndex, section: sectionIndex)]
//                })
//            })
//
//            data = (indexPaths, models)
//
//        case let .insertRowsAtStart(models):
//            let indexPaths = models.indices.map({ IndexPath(row: $0, section: .zero) })
//
//            data = (indexPaths, models)
//
//        case let .insertRowsAtEnd(models):
//            let sectionIndex = self.sections.isEmpty ? 0 : self.sections.count - 1
//            let offset = self.sections.last?.rows.count ?? 0
//            let indexPaths = models.indices.map({ IndexPath(row: $0 + offset, section: sectionIndex) })
//
//            data = (indexPaths, models)
//
//        default:
//            data = nil
//        }
//
//        guard let indexPaths = data?.indexPaths, let models = data?.models else { return nil }
//
//        indexPaths.enumerated().forEach({ modelIndex, indexPath in
//            self.sections[indexPath.section].rows.insert(models[modelIndex], at: indexPath.row)
//        })
//
//        return .insertRows(at: indexPaths, with: animation)
//    }
//
//    open func prepareDeleteRowsUpdater(for action: TableUpdateAction) -> UITableView.Updater? {
//        let animation = action.animation
//        var data: [IndexPath]?
//
//        switch action.type {
//
//        case let .deleteRowsAtIndexPaths(indexPaths):
//            data = indexPaths
//
//        case let .deleteRowsAtRows(rows):
//            var indexPaths: [IndexPath] = []
//
//            rows.forEach({ model in
//                self.sections.enumerated().forEach({ sectionIndex, sectionModel in
//                    guard let rowIndex = sectionModel.rows.firstIndex(where: { $0.isEqualIdentifier(to: model) }) else { return }
//
//                    indexPaths += [.init(row: rowIndex, section: sectionIndex)]
//                })
//            })
//
//            data = indexPaths
//
//        case let .deleteRowsAtStart(count):
//            var indexPaths: [IndexPath] = []
//
//            self.sections.enumerated().forEach({ sectionIndex, sectionModel in
//                guard indexPaths.count < count else { return }
//
//                sectionModel.rows.enumerated().forEach({ rowIndex, rowModel in
//                    guard indexPaths.count < count else { return }
//
//                    indexPaths += [.init(row: rowIndex, section: sectionIndex)]
//                })
//            })
//
//            data = indexPaths
//
//        case let .deleteRowsAtEnd(count):
//            var indexPaths: [IndexPath] = []
//
//            self.sections.enumerated().reversed().forEach({ sectionIndex, sectionModel in
//                guard indexPaths.count < count else { return }
//
//                sectionModel.rows.enumerated().reversed().forEach({ rowIndex, rowModel in
//                    guard indexPaths.count < count else { return }
//
//                    indexPaths += [.init(row: rowIndex, section: sectionIndex)]
//                })
//            })
//
//            data = indexPaths
//
//        default:
//            data = nil
//        }
//
//        guard let indexPaths = data else { return nil }
//
//        var indices: [Int: [Int]] = [:]
//        indexPaths.forEach({ indexPath in
//            indices[indexPath.section] = (indices[indexPath.section] ?? []) + [indexPath.row]
//        })
//
//        indices.forEach({ sectionIndex, rowsIndices in
//            let indicesFilterd = self.sections[sectionIndex].rows.indices.filter({ !rowsIndices.contains($0) })
//            let rowsNew = indicesFilterd.map({ self.sections[sectionIndex].rows[$0] })
//            self.sections[sectionIndex].rows = rowsNew
//        })
//
//        return .deleteRows(at: indexPaths, with: animation)
//    }
//
//    open func prepareReloadRowsUpdater(for action: TableUpdateAction) -> UITableView.Updater? {
//        let animation = action.animation
//        var data: (indexPats: [IndexPath], models: [TableCellModelInput])?
//
//        switch action.type {
//
//        case let .reloadRowsAtIndexPaths(indexPaths, models):
//            data = (indexPaths, models)
//
//        case let .reloadRowsAtRows(rows, models):
//            var indexPaths: [IndexPath] = []
//
//            rows.forEach({ model in
//                self.sections.enumerated().forEach({ sectionIndex, sectionModel in
//                    guard let rowIndex = sectionModel.rows.firstIndex(where: { $0.isEqualIdentifier(to: model) }) else { return }
//
//                    indexPaths += [.init(row: rowIndex, section: sectionIndex)]
//                })
//            })
//
//            data = (indexPaths, models)
//
//        case let .reloadRowsAtStart(models):
//            let indexPaths = models.indices.map({ IndexPath(row: $0, section: .zero) })
//
//            data = (indexPaths, models)
//
//        case let .reloadRowsAtEnd(models):
//            let offset = self.sections.last?.rows.count ?? 0
//            let indexPaths = models.indices.map({ IndexPath(row: $0 + offset, section: self.sections.endIndex) })
//
//            data = (indexPaths, models)
//
//        default:
//            data = nil
//        }
//
//        guard let indexPaths = data?.indexPats, let models = data?.models else { return nil }
//
//        indexPaths.enumerated().forEach({ modelIndex, indexPath in
//            self.sections[indexPath.section].rows[indexPath.row] = models[modelIndex]
//        })
//
//        return .reloadRows(at: indexPaths, with: animation)
//    }
