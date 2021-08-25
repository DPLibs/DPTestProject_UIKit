//import Foundation
//import GKRepresentable
//
//public struct CollectionSection<T: CollectionSectionRepresentable> {
//    public let indexPath: IndexPath
//    public var model: T
//}
//
//public enum CollectionSectionCruderType {
//    case appendSections
//    case insertSections
//    case reloadSections
//    case deleteSections
//}
//
//public struct CollectionSectionCruderAction {
//    public let type: CollectionSectionCruderType
//    public let models: [CollectionSectionRepresentable]
//    public let indicesModels: [Int: CollectionSectionRepresentable]
//    public let indices: [Int]
//    public let animation: UITableView.RowAnimation
//    
//    public var isEmpty: Bool {
//        switch self.type {
//        case .appendSections:
//            return self.models.isEmpty
//        case .insertSections,
//             .reloadSections:
//            return self.indicesModels.isEmpty
//        case .deleteSections:
//            return self.indices.isEmpty
//        }
//    }
//}
//
//public extension CollectionSectionCruderAction {
//    
//    // Append
//    static func appendSection(_ model: CollectionSectionRepresentable, animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .appendSections, models: [model], indicesModels: [:], indices: [], animation: animation)
//    }
//    
//    static func appendSections(_ models: [CollectionSectionRepresentable], animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .appendSections, models: models, indicesModels: [:], indices: [], animation: animation)
//    }
//    
//    // Insert
//    static func insertSection(_ index: Int, _ model: CollectionSectionRepresentable, animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .insertSections, models: [], indicesModels: [index: model], indices: [], animation: animation)
//    }
//    
//    static func insertSections(_ indicesModels: [Int: CollectionSectionRepresentable], animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .insertSections, models: [], indicesModels: indicesModels, indices: [], animation: animation)
//    }
//    
//    // Reload
//    static func reloadSection(_ index: Int, _ model: CollectionSectionRepresentable, animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .reloadSections, models: [], indicesModels: [index: model], indices: [], animation: animation)
//    }
//    
//    static func reloadSections(_ indicesModels: [Int: CollectionSectionRepresentable], animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .reloadSections, models: [], indicesModels: indicesModels, indices: [], animation: animation)
//    }
//    
//    // Delete
//    static func deleteSection(_ index: Int, animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .deleteSections, models: [], indicesModels: [:], indices: [index], animation: animation)
//    }
//    
//    static func deleteSections(_ indices: [Int], animation: UITableView.RowAnimation = .automatic) -> CollectionSectionCruderAction {
//        .init(type: .deleteSections, models: [], indicesModels: [:], indices: indices, animation: animation)
//    }
//    
//}
//
//public protocol CollectionSectionCruderCreator {
//    func appendSections(models: [CollectionSectionRepresentable], animation: UITableView.RowAnimation) -> [DataSourceCruder]
//    func insertSections(indicesModels: [Int: CollectionSectionRepresentable], animation: UITableView.RowAnimation) -> [DataSourceCruder]
//    func reloadSections(indicesModels: [Int: CollectionSectionRepresentable], animation: UITableView.RowAnimation) -> [DataSourceCruder]
//    func deleteSections(indices: [Int], animation: UITableView.RowAnimation) -> [DataSourceCruder]
//}
//
//public extension CollectionSectionCruderCreator {
//    
//    func createCrudersFromActions(sectionActions: [CollectionSectionCruderAction]) -> [DataSourceCruder] {
//        var result: [DataSourceCruder] = []
//        for action in sectionActions {
//            guard !action.isEmpty else { continue }
//            switch action.type {
//            case .appendSections:
//                result.append(contentsOf: self.appendSections(models: action.models, animation: action.animation))
//            case .insertSections:
//                result.append(contentsOf: self.insertSections(indicesModels: action.indicesModels, animation: action.animation))
//            case .reloadSections:
//                result.append(contentsOf: self.reloadSections(indicesModels: action.indicesModels, animation: action.animation))
//            case .deleteSections:
//                result.append(contentsOf: self.deleteSections(indices: action.indices, animation: action.animation))
//            }
//        }
//        return result
//    }
//    
//}
