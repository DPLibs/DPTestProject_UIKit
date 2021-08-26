
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
