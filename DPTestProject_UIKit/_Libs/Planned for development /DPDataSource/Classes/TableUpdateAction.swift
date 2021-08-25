////
////  TableUpdateAction.swift
////  DPDataSource
////
////  Created by Дмитрий Поляков on 19.04.2021.
////
//
//import Foundation
//
//public extension Table {
//    
//    struct TableUpdateAction {
//        
//        public enum ActionType {
//            
//            // MARK: - Insert Sections
//            case insertSectionsAtIndexSet(_ indexSet: IndexSet, models: [TableSectionModelInput])
//            case insertSectionsAtSections(_ sections: [TableSectionModelInput], models: [TableSectionModelInput])
//            case insertSectionsAtStart(models: [TableSectionModelInput])
//            case insertSectionsAtEnd(models: [TableSectionModelInput])
//            
//            // MARK: - Delete Sections
//            case deleteSectionsAtIndexSet(_ indexSet: IndexSet)
//            case deleteSectionsAtSections(_ sections: [TableSectionModelInput])
//            case deleteSectionsAtStart(count: Int)
//            case deleteSectionsAtEnd(count: Int)
//            
//            // MARK: - Reload Sections
//            case reloadSectionsAtIndexSet(_ indexSet: IndexSet, models: [TableSectionModelInput])
//            case reloadSectionsAtSections(_ sections: [TableSectionModelInput], models: [TableSectionModelInput])
//            case reloadSectionsAtStart(models: [TableSectionModelInput])
//            case reloadSectionsAtEnd(models: [TableSectionModelInput])
//            
//            // MARK: - Insert Rows
//            case insertRowsAtIndexPaths(_ indexPaths: [IndexPath], models: [TableCellModelInput])
//            case insertRowsAtRows(_ rows: [TableCellModelInput], models: [TableCellModelInput])
//            case insertRowsAtStart(models: [TableCellModelInput])
//            case insertRowsAtEnd(models: [TableCellModelInput])
//            
//            // MARK: - Delete Rows
//            case deleteRowsAtIndexPaths(_ indexPaths: [IndexPath])
//            case deleteRowsAtRows(_ rows: [TableCellModelInput])
//            case deleteRowsAtStart(count: Int)
//            case deleteRowsAtEnd(count: Int)
//            
//            // MARK: - Reload Rows
//            case reloadRowsAtIndexPaths(_ indexPaths: [IndexPath], models: [TableCellModelInput])
//            case reloadRowsAtRows(_ rows: [TableCellModelInput], models: [TableCellModelInput])
//            case reloadRowsAtStart(models: [TableCellModelInput])
//            case reloadRowsAtEnd(models: [TableCellModelInput])
//        }
//        
//        let type: ActionType
//        let animation: UITableView.RowAnimation
//        
//        public init(type: ActionType, animation: UITableView.RowAnimation) {
//            self.type = type
//            self.animation = animation
//        }
//    }
//    
//}
//
//// MARK: - Store
//public extension Table.TableUpdateAction {
//    
//    // MARK: - For Sections
//    
//    // MARK: - For Rows
//    
//    // MARK: - Insert Rows
//    static func insertRowsAtIndexPaths(
//        _ indexPaths: [IndexPath],
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .insertRowsAtIndexPaths(indexPaths, models: models), animation: animation)
//    }
//    
//    static func insertRowsAtRows(
//        _ rows: [TableCellModelInput],
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .insertRowsAtRows(rows, models: models), animation: animation)
//    }
//    
//    static func insertRowsAtStart(
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Table.TableUpdateAction {
//        .init(type: .insertRowsAtStart(models: models), animation: animation)
//    }
//    
//    static func insertRowsAtEnd(
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .insertRowsAtEnd(models: models), animation: animation)
//    }
//    
//    // MARK: - Delete Rows
//    static func deleteRowsAtIndexPaths(
//        _ indexPaths: [IndexPath],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .deleteRowsAtIndexPaths(indexPaths), animation: animation)
//    }
//    
//    static func deleteRowsAtRows(
//        _ rows: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .deleteRowsAtRows(rows), animation: animation)
//    }
//    
//    static func deleteRowsAtStart(
//        count: Int,
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .deleteRowsAtStart(count: count), animation: animation)
//    }
//    
//    static func deleteRowsAtEnd(
//        count: Int,
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .deleteRowsAtEnd(count: count), animation: animation)
//    }
//    
//    // MARK: - Reload Rows
//    static func reloadRowsAtIndexPaths(
//        _ indexPaths: [IndexPath],
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .reloadRowsAtIndexPaths(indexPaths, models: models), animation: animation)
//    }
//    
//    static func reloadRowsAtRows(
//        _ rows: [TableCellModelInput],
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .reloadRowsAtRows(rows, models: models), animation: animation)
//    }
//    
//    static func reloadRowsAtStart(
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .reloadRowsAtStart(models: models), animation: animation)
//    }
//    
//    static func reloadRowsAtEnd(
//        models: [TableCellModelInput],
//        animation: UITableView.RowAnimation
//    ) -> Self {
//        .init(type: .reloadRowsAtEnd(models: models), animation: animation)
//    }
//    
//    
//}
