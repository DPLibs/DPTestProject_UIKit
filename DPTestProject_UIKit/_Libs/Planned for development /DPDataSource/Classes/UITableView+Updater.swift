////
////  UITableView+updater.swift
////  DPDataSource
////
////  Created by mac mini on 14.04.2021.
////
//
//import Foundation
//import UIKit
//
//public extension UITableView {
//    
//    struct Updater {
//        public let segment: DataSource.SegmentType
//        public let update: DataSource.UpdateType
//        public let element: DataSource.ElementPosition
//        public let move: DataSource.MovePosition
//        public let animation: UITableView.RowAnimation
//    }
//    
//    func performUpdaters(_ updaters: [UITableView.Updater], completion: ((Bool) -> Void)?) {
//        let updates: (() -> Void)? = { [weak self] in
//            guard let self = self else { return }
//
//            updaters.forEach({ updater in
//                let segment = updater.segment
//                let update = updater.update
//                let element = updater.element
//                let move = updater.move
//                let animation = updater.animation
//
//                switch update {
//                case .insert:
//                    switch segment {
//                    case .section:
//                        guard let indexSet = element.indexSet else { return }
//                        self.insertSections(indexSet, with: animation)
//                    case .row:
//                        guard let indexPaths = element.indexPaths else { return }
//                        self.insertRows(at: indexPaths, with: animation)
//                    default:
//                        break
//                    }
//                case .delete:
//                    switch segment {
//                    case .section:
//                        guard let indexSet = element.indexSet else { return }
//                        self.deleteSections(indexSet, with: animation)
//                    case .row:
//                        guard let indexPaths = element.indexPaths else { return }
//                        self.deleteRows(at: indexPaths, with: animation)
//                    default:
//                        break
//                    }
//                case .reload:
//                    switch segment {
//                    case .section:
//                        guard let indexSet = element.indexSet else { return }
//                        self.reloadSections(indexSet, with: animation)
//                    case .row:
//                        guard let indexPaths = element.indexPaths else { return }
//                        self.reloadRows(at: indexPaths, with: animation)
//                    default:
//                        break
//                    }
//                case .move:
//                    switch segment {
//                    case .row:
//                        guard let indexPaths = move.indexPaths else { return }
//                        self.moveRow(at: indexPaths.atIndexPath, to: indexPaths.toIndexIndexPath)
//                    case .section:
//                        guard let indices = move.indices else { return }
//                        self.moveSection(indices.atIndex, toSection: indices.toIndex)
//                    default:
//                        break
//                    }
//                }
//            })
//        }
//
//        self.performBatchUpdates(updates, completion: completion)
//    }
//    
//}
//
//// MARK: - UITableView.Updater + Store
//public extension UITableView.Updater {
//
//    // MARK: - For Sections
//    static func insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) -> Self {
//        .init(
//            segment: .section,
//            update: .insert,
//            element: .indexSet(sections),
//            move: .none,
//            animation: animation
//        )
//    }
//
//    static func deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) -> Self {
//        .init(
//            segment: .section,
//            update: .delete,
//            element: .indexSet(sections),
//            move: .none,
//            animation: animation
//        )
//    }
//
//    static func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) -> Self {
//        .init(
//            segment: .section,
//            update: .reload,
//            element: .indexSet(sections),
//            move: .none,
//            animation: animation
//        )
//    }
//
//    static func moveSection(_ section: Int, toSection newSection: Int) -> Self {
//        .init(
//            segment: .section,
//            update: .move,
//            element: .none,
//            move: .indices(atIndex: section, toIndex: newSection),
//            animation: .none
//        )
//    }
//
//    // MARK: - For Rows
//    static func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) -> Self {
//        .init(
//            segment: .row,
//            update: .insert,
//            element: .indexPaths(indexPaths),
//            move: .none,
//            animation: animation
//        )
//    }
//
//    static func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) -> Self {
//        .init(
//            segment: .row,
//            update: .delete,
//            element: .indexPaths(indexPaths),
//            move: .none,
//            animation: animation
//        )
//    }
//
//    static func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) -> Self {
//        .init(
//            segment: .row,
//            update: .reload,
//            element: .indexPaths(indexPaths),
//            move: .none,
//            animation: animation
//        )
//    }
//
//    static func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) -> Self {
//        .init(
//            segment: .row,
//            update: .move,
//            element: .none,
//            move: .indexPaths(atIndexPath: indexPath, toIndexIndexPath: newIndexPath),
//            animation: .none
//        )
//    }
//
//}
