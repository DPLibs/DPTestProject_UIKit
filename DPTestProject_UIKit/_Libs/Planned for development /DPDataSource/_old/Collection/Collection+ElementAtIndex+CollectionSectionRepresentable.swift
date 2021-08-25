//import Foundation
//import GKRepresentable
//import DPLibrary
//
//extension Collection where Element == CollectionSectionRepresentable {
//    
//    func item(at indexPath: IndexPath) -> CollectionCellIdentifiable? {
//        guard let section = indexPath.section as? Self.Index else { return nil }
//        return self.element(at: section)?.items.element(at: indexPath.row)
//    }
//    
//    func item<T>(at indexPath: IndexPath, isAn type: T.Type) -> T? {
//        guard let section = indexPath.section as? Self.Index else { return nil }
//        return self.element(at: section)?.items.element(at: indexPath.row) as? T
//    }
//    
//}
