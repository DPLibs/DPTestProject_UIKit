//import Foundation
//import UIKit
//
//public extension UICollectionView {
//    
//    func performBatchUpdates(_ cruders: [DataSourceCruder], completion: ((Bool) -> Void)?) {
//        let crudersFilterd = cruders.filter({ !$0.isEmpty && $0.type.viewType == .collection })
//        guard !crudersFilterd.isEmpty else {
//            completion?(false)
//            return
//        }
//        self.performBatchUpdates({ [weak self] in
//            guard let self = self else { return }
//            for cruder in cruders {
//                let type = cruder.type
//                let indexPaths = cruder.indexPaths
//                
//                switch type {
//                case .appendItems,
//                     .insertItems:
//                    self.insertItems(at: indexPaths)
//                case .reloadItems:
//                    self.reloadItems(at: indexPaths)
//                case .deleteItems:
//                    self.deleteItems(at: indexPaths)
//                default:
//                    continue
//                }
//            }
//        }, completion: completion)
//    }
//    
//}
