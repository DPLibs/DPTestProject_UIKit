
//// MARK: - Output
//public protocol CollectionAdapterOutput: AnyObject {
//    func beginRefreshing(adapter: CollectionAdapter)
//    func endRefreshing(adapter: CollectionAdapter)
//    func startAchived(adapter: CollectionAdapter)
//    func endAchived(adapter: CollectionAdapter)
//    func didItemsOffset(adapter: CollectionAdapter, itemsCount: Int, startOffset: Int, endOffset: Int)
//    func didSelectItemAt(adapter: CollectionAdapter, indexPath: IndexPath, model: CollectionCellIdentifiable, cell: UICollectionViewCell)
//    func scrollEndingOnCellFroCustomPaging(adapter: CollectionAdapter, indexPath: IndexPath, model: CollectionCellIdentifiable, cell: UICollectionViewCell)
//    func willDisplay(adapter: CollectionAdapter, indexPath: IndexPath, model: CollectionCellIdentifiable, cell: UICollectionViewCell)
//}
//
//public extension CollectionAdapterOutput {
//    func beginRefreshing(adapter: CollectionAdapter) {}
//    func endRefreshing(adapter: CollectionAdapter) {}
//    func startAchived(adapter: CollectionAdapter) {}
//    func endAchived(adapter: CollectionAdapter) {}
//    func didItemsOffset(adapter: CollectionAdapter, itemsCount: Int, startOffset: Int, endOffset: Int) {}
//    func didSelectItemAt(adapter: CollectionAdapter, indexPath: IndexPath, model: CollectionCellIdentifiable, cell: UICollectionViewCell) {}
//    func scrollEndingOnCellFroCustomPaging(adapter: CollectionAdapter, indexPath: IndexPath, model: CollectionCellIdentifiable, cell: UICollectionViewCell) {}
//    func willDisplay(adapter: CollectionAdapter, indexPath: IndexPath, model: CollectionCellIdentifiable, cell: UICollectionViewCell) {}
//}
//
//// MARK: - OutputUI
//public protocol CollectionAdapterOutputUI: AnyObject {
//    func cellForItemAt(adapter: CollectionAdapter, at indexPath: IndexPath, cell: UICollectionViewCell)
//    func scrollContentOffsetY(adapter: CollectionAdapter, offsetY: CGFloat)
//    func scrollTopAchived(adapter: CollectionAdapter, isAchived: Bool)
//    func scrollBottomAchived(adapter: CollectionAdapter, isAchived: Bool)
//    func insetForSectionAt(adapter: CollectionAdapter, section: Int) -> UIEdgeInsets
//    func scrollViewDidEndScrollingAnimation(adapter: CollectionAdapter)
//    func scrollViewWillEndDragging(adapter: CollectionAdapter)
//}
//
//public extension CollectionAdapterOutputUI {
//    func cellForItemAt(adapter: CollectionAdapter, at indexPath: IndexPath, cell: UICollectionViewCell) {}
//    func scrollContentOffsetY(adapter: CollectionAdapter, offsetY: CGFloat) {}
//    func scrollTopAchived(adapter: CollectionAdapter, isAchived: Bool) {}
//    func scrollBottomAchived(adapter: CollectionAdapter, isAchived: Bool) {}
//    func insetForSectionAt(adapter: CollectionAdapter, section: Int) -> UIEdgeInsets { .zero }
//    func scrollViewDidEndScrollingAnimation(adapter: CollectionAdapter) {}
//    func scrollViewWillEndDragging(adapter: CollectionAdapter) {}
//}
//
//open class CollectionAdapter: NSObject, CollectionAdapterInput, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionCruderPerformer {
//    
//    // MARK: - Props
//    private var _draggingWillStarted: Bool = false
//    
//    weak var output: CollectionAdapterOutput?
//    weak var outputUI: CollectionAdapterOutputUI?
//    
//    public weak var collection: UICollectionView? {
//        didSet {
//            self.collection?.delegate = self
//            self.collection?.dataSource = self
//        }
//    }
//    
//    public var sections: [CollectionSectionRepresentable] = []
//    
//    public var itemsCount: Int {
//        self.sections.reduce(0, { result, section in result + section.items.count })
//    }
//    
//    // MARK: - Methods
//    public func subscribe(output: CollectionAdapterOutput) {
//        self.output = output
//    }
//     
//    public func subscribe(outputUI: CollectionAdapterOutputUI) {
//        self.outputUI = outputUI
//    }
//    
//    public func setupCollection(_ collection: UICollectionView?) {
//        self.collection = collection
//    }
//    
//    public func setupPlugins(_ plugins: [DataSourceAdapterPlugin]) {
//        for plugin in plugins {
//            switch plugin {
//            case let refreshControl as UIRefreshControl:
//                self.setupRefreshControl(refreshControl)
//            case let dataSourceEmptyView as DataSourceEmptyView:
//                dataSourceEmptyView.append(to: self.collection)
//            default:
//                continue
//            }
//        }
//    }
//    
//    // MARK: - Refersh
//    public func setupRefreshControl(_ refreshControl: UIRefreshControl) {
//        self.collection?.refreshControl?.removeFromSuperview()
//        refreshControl.addTarget(self, action: #selector(self.didRefreshControlValueChanged), for: .valueChanged)
//        self.collection?.refreshControl = refreshControl
//        self.collection?.bringSubviewToFront(refreshControl)
//    }
//    
//    public func updateRefreshControlUI() {
//        guard let refreshControl = self.collection?.refreshControl else { return }
//        self.setupRefreshControl(refreshControl)
//    }
//    
//    public var isRefreshing: Bool {
//        self.collection?.refreshControl?.isRefreshing == true
//    }
//    
//    public func beginRefreshing() {
//        self.sections.removeAll()
//        self.collection?.reloadData()
//        self.collection?.refreshControl?.beginRefreshing()
//        self.output?.beginRefreshing(adapter: self)
//    }
//    
//    public func endRefreshing() {
//        self.collection?.refreshControl?.endRefreshing()
//        self.output?.endRefreshing(adapter: self)
//    }
//    
//    @objc
//    private func didRefreshControlValueChanged() {
//        self.output?.beginRefreshing(adapter: self)
//    }
//    
//    // MARK: - EmptyView
//    public func updateEmptyViewAuto() {
//        var isHidden: Bool = false
//        for section in self.sections {
//            guard !section.items.isEmpty else { continue }
//            isHidden = true
//            break
//        }
//        self.collection?.updateDataSourceEmptyView(isHidden: isHidden)
//    }
//    
//    public func updateEmptyView(isHidden: Bool) {
//        self.collection?.updateDataSourceEmptyView(isHidden: isHidden)
//    }
//    
//    // MARK: - Reload/Perform - Section
//    public func reload(sections: [CollectionSectionRepresentable]) {
//        self.endRefreshing()
//        self.sections = sections
//        self.collection?.reloadData()
//        self.updateEmptyViewAuto()
//    }
//    
//    public func perfrom(sectionActions: [CollectionSectionCruderAction], completion: ((Bool) -> Void)?) {
//        self.endRefreshing()
//        self.performBatchUpdates(sectionActions: sectionActions) { [weak self] completed in
//            completion?(completed)
//            self?.updateEmptyViewAuto()
//        }
//    }
//    
//    public func perform(sectionAction: CollectionSectionCruderAction, completion: ((Bool) -> Void)?) {
//        self.perfrom(sectionActions: [sectionAction], completion: completion)
//    }
//    
//    public func reloadOrAppendSections(needReload: Bool, sections: [CollectionSectionRepresentable]) {
//        if needReload {
//            self.reload(sections: sections)
//        } else {
//            self.perform(sectionAction: .appendSections(sections, animation: .automatic), completion: nil)
//        }
//    }
//    
//    // MARK: - Reload/Perform - Row
//    public func reload(items: [CollectionCellIdentifiable], sectionIndex: Int) {
//        self.endRefreshing()
//        if self.sections.indices.contains(sectionIndex) {
//            self.sections[sectionIndex].items = items
//        }
//        self.collection?.reloadData()
//        self.updateEmptyViewAuto()
//    }
//    
//    public func perfrom(itemActions: [CollectionItemCruderAction], completion: ((Bool) -> Void)?) {
//        self.endRefreshing()
//        self.performBatchUpdates(itemActions: itemActions) { [weak self] completed in
//            completion?(completed)
//            self?.updateEmptyViewAuto()
//        }
//    }
//    
//    public func perform(itemAction: CollectionItemCruderAction, completion: ((Bool) -> Void)?) {
//        self.perfrom(itemActions: [itemAction], completion: completion)
//    }
//    
//    public func reloadOrAppendItems(needReload: Bool, items: [CollectionCellIdentifiable], sectionIndex: Int) {
//        if needReload {
//            self.reload(items: items, sectionIndex: sectionIndex)
//        } else {
//            self.perform(itemAction: .appendItems(items, section: sectionIndex), completion: nil)
//        }
//    }
//    
//    // MARK: - UICollectionViewDataSource
//    public func numberOfSections(in collectionView: UICollectionView) -> Int {
//        self.sections.count
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard self.sections.indices.contains(section) else { return .zero }
//        return self.sections[section].items.count
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard
//            let model = self.sections.item(at: indexPath),
//            !model.cellIdentifier.isEmpty,
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.cellIdentifier, for: indexPath) as? CollectionCell
//        else { return UICollectionViewCell() }
//        cell.model = model
//        self.outputUI?.cellForItemAt(adapter: self, at: indexPath, cell: cell)
//        return cell
//    }
//
//    // MARK: - UICollectionViewDelegate
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y
//        self.outputUI?.scrollContentOffsetY(adapter: self, offsetY: offset)
//        let bottomAchivedValue = scrollView.contentSize.height - scrollView.frame.size.height + scrollView.contentInset.top + scrollView.contentInset.bottom
//        
//        guard self._draggingWillStarted else { return }
//        let topAchived = offset <= -scrollView.contentInset.top
//        let bottomAchived = offset >= (bottomAchivedValue < 0 ? 0 : bottomAchivedValue)
//        
//        self.outputUI?.scrollTopAchived(adapter: self, isAchived: topAchived)
//        self.outputUI?.scrollBottomAchived(adapter: self, isAchived: bottomAchived)
//    }
//    
//    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        self.outputUI?.scrollViewDidEndScrollingAnimation(adapter: self)
//    }
//    
//    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self._draggingWillStarted = true
//        
//        switch self.customPagingMode {
//        case .none:
//            break
//        case let .enabledWithItemWidth(width):
//            self.scrollViewWillBeginDraggingCustomPaging(scrollView, pageWidth: width)
//        }
//    }
//    
//    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        self.outputUI?.scrollViewWillEndDragging(adapter: self)
//        
//        switch self.customPagingMode {
//        case .none:
//            break
//        case let .enabledWithItemWidth(width):
//            self.scrollViewWillEndDraggingCustomPaging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset, pageWidth: width)
//        }
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard
//            self.sections.indices.contains(indexPath.section),
//            self.sections[indexPath.section].items.indices.contains(indexPath.item),
//            let cell = collectionView.cellForItem(at: indexPath)
//        else { return }
//        let model = self.sections[indexPath.section].items[indexPath.item]
//        self.output?.didSelectItemAt(adapter: self, indexPath: indexPath, model: model, cell: cell)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath == IndexPath(row: 0, section: 0) {
//            self.output?.startAchived(adapter: self)
//        }
//        
//        if indexPath.section + 1 == self.sections.endIndex, indexPath.row + 1 == self.sections.last?.items.endIndex {
//            self.output?.endAchived(adapter: self)
//        }
//        
//        let itemsCount = self.itemsCount
//        var startOffset: Int = indexPath.row
//        
//        if indexPath.section > 0 {
//            for i in 0...indexPath.section - 1 {
//                guard self.sections.indices.contains(i) else { continue }
//                startOffset += self.sections[i].items.count
//            }
//        }
//        
//        let endOffset = itemsCount - startOffset
//        self.output?.didItemsOffset(adapter: self, itemsCount: itemsCount, startOffset: startOffset, endOffset: endOffset)
//        
//        if let model = self.sections.element(at: indexPath.section)?.items.element(at: indexPath.item) {
//            self.output?.willDisplay(adapter: self, indexPath: indexPath, model: model, cell: cell)
//        }
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard
//            self.sections.indices.contains(indexPath.section),
//            self.sections[indexPath.section].items.indices.contains(indexPath.item)
//        else { return .zero }
//        return self.sections[indexPath.section].items[indexPath.item].cellSize
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        self.outputUI?.insetForSectionAt(adapter: self, section: section) ?? .zero
//    }
//    
//    // MARK: - CollectionItemCruderCreator
//    public func appendItems(models: [CollectionCellIdentifiable], section: Int) -> [DataSourceCruder] {
//        guard let creator = self.sections.element(at: section) as? CrudableCollectionSectionModel else { return [] }
//        return creator.appendItems(models: models, section: section)
//    }
//    
//    public func insertItems(indicesModels: [Int: CollectionCellIdentifiable], section: Int) -> [DataSourceCruder] {
//        guard let creator = self.sections.element(at: section) as? CrudableCollectionSectionModel else { return [] }
//        return creator.insertItems(indicesModels: indicesModels, section: section)
//    }
//    
//    public func reloadItems(indicesModels: [Int: CollectionCellIdentifiable], section: Int) -> [DataSourceCruder] {
//        guard let creator = self.sections.element(at: section) as? CrudableCollectionSectionModel else { return [] }
//        return creator.reloadItems(indicesModels: indicesModels, section: section)
//    }
//    
//    public func deleteItems(indices: [Int], section: Int) -> [DataSourceCruder] {
//        guard let creator = self.sections.element(at: section) as? CrudableCollectionSectionModel else { return [] }
//        return creator.deleteItems(indices: indices, section: section)
//    }
//    
//    // MARK: - CollectionSectionCruderCreator
//    public func appendSections(models: [CollectionSectionRepresentable], animation: UITableView.RowAnimation) -> [DataSourceCruder] {
//        let countBeforeAppend = self.sections.count
//        self.sections.append(contentsOf: models)
//        let indexSet = IndexSet(models.indices.map({ $0 + countBeforeAppend }))
//        return [.insertSections(indexSet, animation: animation)]
//    }
//    
//    public func insertSections(indicesModels: [Int: CollectionSectionRepresentable], animation: UITableView.RowAnimation) -> [DataSourceCruder] {
//        var indexSet = IndexSet()
//        for (index, section) in indicesModels {
//            self.sections.insert(section, at: index)
//            indexSet.insert(index)
//        }
//        return [.insertSections(indexSet, animation: animation)]
//    }
//    
//    public func reloadSections(indicesModels: [Int: CollectionSectionRepresentable], animation: UITableView.RowAnimation) -> [DataSourceCruder] {
//        var indexSet = IndexSet()
//        for (index, section) in indicesModels {
//            guard self.sections.indices.contains(index) else { continue }
//            self.sections[index] = section
//            indexSet.insert(index)
//        }
//        return [.reloadSections(indexSet, animation: animation)]
//    }
//    
//    public func deleteSections(indices: [Int], animation: UITableView.RowAnimation) -> [DataSourceCruder] {
//        var indexList: [Int] = []
//        var indexSet = IndexSet()
//        for index in indices {
//            guard self.sections.indices.contains(index) else { continue }
//            indexList.append(index)
//            indexSet.insert(index)
//        }
//        self.sections.removeAll(at: indexList)
//        return [.deleteSections(indexSet, animation: animation)]
//    }
//    
//    // MARK: - Get/Set - IndexPath
//    public func indexPath(for cell: UICollectionViewCell?) -> IndexPath? {
//        guard let cell = cell, let indexPath = self.collection?.indexPath(for: cell) else { return nil }
//        return indexPath
//    }
//
//    // MARK: - Get/Set - Row
//    public func getRow<T: CollectionCellIdentifiable>(_ getType: DataSourceGetDataType, isAn type: T.Type) -> CollectionItem<T>? {
//        var path: IndexPath?
//        switch getType {
//        case let .indexPath(indexPath):
//            path = indexPath
//        case let .collectionCell(cell):
//            path = self.collection?.indexPath(for: cell)
//        case .tableCell:
//            break
//        }
//        guard let indexPath = path, let model = self.sections.item(at: indexPath, isAn: T.self) else { return nil }
//        return CollectionItem<T>(indexPath: indexPath, model: model)
//    }
//    
//    public func setRow<T: CollectionCellIdentifiable>(_ data: CollectionItem<T>) {
//        let indexPath = data.indexPath
//        guard self.sections.item(at: data.indexPath) != nil else { return }
//        self.sections[indexPath.section].items[indexPath.row] = data.model
//    }
//    
//    // MARK: - Get/Set - Section
//    public func getSection<T: CollectionSectionRepresentable>(_ getType: DataSourceGetDataType, isAn type: T.Type) -> TableSection<T>? {
//        var path: IndexPath?
//        switch getType {
//        case let .indexPath(indexPath):
//            path = indexPath
//        case let .collectionCell(cell):
//            path = self.collection?.indexPath(for: cell)
//        case .tableCell:
//            break
//        }
//        guard let indexPath = path, let model = self.sections.element(at: indexPath.section) as? T else { return nil }
//        return TableSection<T>(indexPath: indexPath, model: model)
//    }
//    
//    public func setSection<T: CollectionSectionRepresentable>(_ data: CollectionSection<T>) {
//        let indexPath = data.indexPath
//        guard self.sections.element(at: data.indexPath.section) != nil else { return }
//        self.sections[indexPath.section] = data.model
//    }
//    
//    // MARK: - Scroll
//    public func scrollToItem(at indexPath: IndexPath, position: UICollectionView.ScrollPosition, animated: Bool) {
//        self.collection?.scrollToItem(at: indexPath, at: position, animated: animated)
//    }
//
//    public func scrollToItem(for cell: UICollectionViewCell?, position: UICollectionView.ScrollPosition, animated: Bool) {
//        guard let cell = cell, let indexPath = self.collection?.indexPath(for: cell) else { return }
//        self.collection?.scrollToItem(at: indexPath, at: position, animated: animated)
//    }
//    
//    // MARK: - Custom paging methods
//    public enum CustomPagingMode {
//        case none
//        case enabledWithItemWidth(_ width: CGFloat)
//    }
//    
//    public var customPagingMode: CustomPagingMode = .none
//    private var indexOfCellBeforeDragging = 0
//     
//    open func scrollViewWillBeginDraggingCustomPaging(_ scrollView: UIScrollView, pageWidth: CGFloat) {
//        let proportionalOffset: CGFloat = scrollView.contentOffset.x / pageWidth
//        self.indexOfCellBeforeDragging = Int(round(proportionalOffset))
//    }
//    
//    open func scrollViewWillEndDraggingCustomPaging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>, pageWidth: CGFloat) {
//        targetContentOffset.pointee = scrollView.contentOffset
//        
//        let collectionViewItemCount = self.sections.first?.items.count ?? 0// The number of items in this section
//        let proportionalOffset = scrollView.contentOffset.x / pageWidth
//        let indexOfMajorCell = Int(round(proportionalOffset))
//        let swipeVelocityThreshold: CGFloat = 0.5
//        let hasEnoughVelocityToSlideToTheNextCell = self.indexOfCellBeforeDragging + 1 < collectionViewItemCount && velocity.x > swipeVelocityThreshold
//        let hasEnoughVelocityToSlideToThePreviousCell = self.indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
//        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == self.indexOfCellBeforeDragging
//        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
//
//        if didUseSwipeToSkipCell {
//            // Animate so that swipe is just continued
//            let snapToIndex = self.indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
//            let toValue = pageWidth * CGFloat(snapToIndex)
//            UIView.animate(
//                withDuration: 0.3,
//                delay: 0,
//                usingSpringWithDamping: 1,
//                initialSpringVelocity: velocity.x,
//                options: .allowUserInteraction,
//                animations: {
//                    scrollView.contentOffset = CGPoint(x: toValue, y: 0)
//                    scrollView.layoutIfNeeded()
//                },
//                completion: { [weak self] _ in
//                    self?.provideScrollEndingOnCellFroCustomPaging(indexPath: self?.collection?.indexPathForItem(at: scrollView.contentOffset))
//                }
//            )
//        } else {
//            // Pop back (against velocity)
//            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
//            collection?.scrollToItem(at: indexPath, at: .left, animated: true)
//            self.provideScrollEndingOnCellFroCustomPaging(indexPath: indexPath)
//        }
//    }
//    
//    private func provideScrollEndingOnCellFroCustomPaging(indexPath: IndexPath?) {
//        guard
//            let indexPath = indexPath,
//            let model = self.sections.element(at: indexPath.section)?.items.element(at: indexPath.item),
//            let cell = self.collection?.cellForItem(at: indexPath)
//        else { return }
//        
//        self.output?.scrollEndingOnCellFroCustomPaging(adapter: self, indexPath: indexPath, model: model, cell: cell)
//    }
//}
