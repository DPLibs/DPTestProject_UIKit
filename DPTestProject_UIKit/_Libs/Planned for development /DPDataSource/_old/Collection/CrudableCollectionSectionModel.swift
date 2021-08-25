//import Foundation
//import GKRepresentable
//
//open class CrudableCollectionSectionModel: CollectionSectionRepresentable, CollectionItemCruderCreator {
//    
//    // MARK: - Props
//    open var items: [CollectionCellIdentifiable]
//    
//    // MARK: - Initialization
//    public init(items: [CollectionCellIdentifiable]) {
//        self.items = items
//    }
//    
//    // MARK: - RowTableCruderCreator
//    public func appendItems(models: [CollectionCellIdentifiable], section: Int) -> [DataSourceCruder] {
//        let countBeforeAppend = self.items.count
//        self.items.append(contentsOf: self.items)
//        let indexPaths = models.indices.map {
//            IndexPath(row: $0 + countBeforeAppend, section: section)
//        }
//        return [.appendItems(indexPaths)]
//    }
//    
//    public func insertItems(indicesModels: [Int: CollectionCellIdentifiable], section: Int) -> [DataSourceCruder] {
//        var indexPaths: [IndexPath] = []
//        for (index, model) in indicesModels {
//            self.items.insert(model, at: index)
//            indexPaths.append(IndexPath(row: index, section: section))
//        }
//        return [.insertItems(indexPaths)]
//    }
//    
//    public func reloadItems(indicesModels: [Int: CollectionCellIdentifiable], section: Int) -> [DataSourceCruder] {
//        var indexPaths: [IndexPath] = []
//        for (index, model) in indicesModels {
//            guard self.items.indices.contains(index) else { continue }
//            self.items[index] = model
//            indexPaths.append(IndexPath(row: index, section: section))
//        }
//        return [.reloadItems(indexPaths)]
//    }
//    
//    public func deleteItems(indices: [Int], section: Int) -> [DataSourceCruder] {
//        var indexList: [Int] = []
//        var indexPaths: [IndexPath] = []
//        for index in indices {
//            guard self.items.indices.contains(index) else { continue }
//            indexList.append(index)
//            indexPaths.append(IndexPath(item: index, section: section))
//        }
//        self.items.removeAll(at: indexList)
//        return [.deleteItems(indexPaths)]
//    }
//    
//}
