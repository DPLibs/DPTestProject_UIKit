//import Foundation
//import UIKit
//
//public protocol CollectionCruderPerformer: AnyObject, CollectionItemCruderCreator, CollectionSectionCruderCreator {
//    var collection: UICollectionView? { get }
//    
//    func performBatchUpdates(itemActions: [CollectionItemCruderAction], completion: ((Bool) -> Void)?)
//    func performBatchUpdates(sectionActions: [CollectionSectionCruderAction], completion: ((Bool) -> Void)?)
//}
//
//public extension CollectionCruderPerformer {
//    
//    func performBatchUpdates(itemActions: [CollectionItemCruderAction], completion: ((Bool) -> Void)?) {
//        self.collection?.performBatchUpdates(self.createCrudersFromActions(itemActions: itemActions), completion: completion)
//    }
//    
//    func performBatchUpdates(sectionActions: [CollectionSectionCruderAction], completion: ((Bool) -> Void)?) {
//        self.collection?.performBatchUpdates(self.createCrudersFromActions(sectionActions: sectionActions), completion: completion)
//    }
//    
//}
