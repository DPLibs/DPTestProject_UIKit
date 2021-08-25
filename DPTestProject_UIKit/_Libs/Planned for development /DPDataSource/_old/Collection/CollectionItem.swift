//import Foundation
//import GKRepresentable
//
//public struct CollectionItem<T: CollectionCellIdentifiable> {
//    public let indexPath: IndexPath
//    public var model: T
//}
//
//public enum CollectionItemCruderType {
//    case appendItems
//    case insertItems
//    case reloadItems
//    case deleteItems
//}
//
//public struct CollectionItemCruderAction {
//    public let type: CollectionItemCruderType
//    public let models: [CollectionCellIdentifiable]
//    public let indicesModels: [Int: CollectionCellIdentifiable]
//    public let indices: [Int]
//    public let section: Int
//    
//    public var isEmpty: Bool {
//        switch self.type {
//        case .appendItems:
//            return self.models.isEmpty
//        case .insertItems,
//             .reloadItems:
//            return self.indicesModels.isEmpty
//        case .deleteItems:
//            return self.indices.isEmpty
//        }
//    }
//}
//
//public extension CollectionItemCruderAction {
//    
//    // Append
//    static func appendItem(_ model: CollectionCellIdentifiable, section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .appendItems, models: [model], indicesModels: [:], indices: [], section: section)
//    }
//    
//    static func appendItems(_ models: [CollectionCellIdentifiable], section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .appendItems, models: models, indicesModels: [:], indices: [], section: section)
//    }
//    
//    // Insert
//    static func insertItem(_ index: Int, _ model: CollectionCellIdentifiable, section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .insertItems, models: [], indicesModels: [index: model], indices: [], section: section)
//    }
//    
//    static func insertItems(_ indicesModels: [Int: CollectionCellIdentifiable], section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .insertItems, models: [], indicesModels: indicesModels, indices: [], section: section)
//    }
//    
//    // Reload
//    static func reloadItem(_ index: Int, _ model: CollectionCellIdentifiable, section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .reloadItems, models: [], indicesModels: [index: model], indices: [], section: section)
//    }
//    
//    static func reloadItems(_ indicesModels: [Int: CollectionCellIdentifiable], section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .reloadItems, models: [], indicesModels: indicesModels, indices: [], section: section)
//    }
//    
//    // Delete
//    static func deleteItem(_ index: Int, section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .deleteItems, models: [], indicesModels: [:], indices: [index], section: section)
//    }
//    
//    static func deleteItems(_ indices: [Int], section: Int = .zero) -> CollectionItemCruderAction {
//        CollectionItemCruderAction(type: .deleteItems, models: [], indicesModels: [:], indices: indices, section: section)
//    }
//    
//}
//
//public protocol CollectionItemCruderCreator {
//    func appendItems(models: [CollectionCellIdentifiable], section: Int) -> [DataSourceCruder]
//    func insertItems(indicesModels: [Int: CollectionCellIdentifiable], section: Int) -> [DataSourceCruder]
//    func reloadItems(indicesModels: [Int: CollectionCellIdentifiable], section: Int) -> [DataSourceCruder]
//    func deleteItems(indices: [Int], section: Int) -> [DataSourceCruder]
//}
//
//public extension CollectionItemCruderCreator {
//    
//    func createCrudersFromActions(itemActions: [CollectionItemCruderAction]) -> [DataSourceCruder] {
//        var result: [DataSourceCruder] = []
//        for action in itemActions {
//            guard !action.isEmpty else { continue }
//            switch action.type {
//            case .appendItems:
//                result.append(contentsOf: self.appendItems(models: action.models, section: action.section))
//            case .insertItems:
//                result.append(contentsOf: self.insertItems(indicesModels: action.indicesModels, section: action.section))
//            case .reloadItems:
//                result.append(contentsOf: self.reloadItems(indicesModels: action.indicesModels, section: action.section))
//            case .deleteItems:
//                result.append(contentsOf: self.deleteItems(indices: action.indices, section: action.section))
//            }
//        }
//        return result
//    }
//    
//}
