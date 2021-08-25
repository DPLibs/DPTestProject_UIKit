////
////  DataSourceDirection.swift
////  DPDataSource
////
////  Created by mac mini on 14.04.2021.
////
//
//import Foundation
//
//public enum DataSource {
//    
//    public enum SegmentType {
//        case section
//        case row
//        case item
//    }
//    
//    public enum UpdateType {
//        case reload
//        case insert
//        case delete
//        case move
//    }
//    
//    public enum ElementPosition {
//        case none
//        case indexSet(_ indexSet: IndexSet)
//        case indexPaths(_ indexPaths: [IndexPath])
//        
//        var indexSet: IndexSet? {
//            switch self {
//            case let .indexSet(indexSet):
//                return indexSet
//            default:
//                return nil
//            }
//        }
//        
//        var indexPaths: [IndexPath]? {
//            switch self {
//            case let .indexPaths(indexPaths):
//                return indexPaths
//            default:
//                return nil
//            }
//        }
//    }
//    
//    public enum MovePosition {
//        case none
//        case indices(atIndex: Int, toIndex: Int)
//        case indexPaths(atIndexPath: IndexPath, toIndexIndexPath: IndexPath)
//         
//        var indices: (atIndex: Int, toIndex: Int)? {
//            switch self {
//            case let .indices(atIndex, toIndex):
//                return (atIndex, toIndex)
//            default:
//                return nil
//            }
//        }
//        
//        var indexPaths: (atIndexPath: IndexPath, toIndexIndexPath: IndexPath)? {
//            switch self {
//            case let .indexPaths(atIndexPath, toIndexIndexPath):
//                return (atIndexPath, toIndexIndexPath)
//            default:
//                return nil
//            }
//        }
//    }
//    
//}
