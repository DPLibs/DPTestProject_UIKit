import Foundation

// MARK: - Section
open class DPTableSection {

    // MARK: - Props
    open var rows: [DPTableCell.ViewModel]
    open var header: DPTableSectionHeader.ViewModel?
    open var footer: DPTableSectionHeader.ViewModel?

    // MARK: - Init
    public init(
        rows: [DPTableCell.ViewModel],
        header: DPTableSectionHeader.ViewModel? = nil,
        footer: DPTableSectionHeader.ViewModel? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }
    
//    open var identifier: String = ""
    ////// MARK: - Equatable
    ////extension TableSectionModel: Equatable {
    ////
    ////    public static func == (lhs: TableSectionModel, rhs: TableSectionModel) -> Bool {
    ////        guard !lhs.identifier.isEmpty, !rhs.identifier.isEmpty else { return false }
    ////
    ////        return lhs.identifier == rhs.identifier
    ////    }
    ////
    ////}

}

public extension DPTableSection {
    
    func getRow(at index: Int) -> DPTableCell.ViewModel? {
        guard self.rows.indices.contains(index) else { return nil }
        
        return self.rows[index]
    }
    
//    func insertRow(at index: Int) {
//
//    }
    
}

public extension Array where Element == DPTableSection {
    
    func getRow(at indexPath: IndexPath) -> DPTableCell.ViewModel? {
        guard self.indices.contains(indexPath.section) else { return nil }
        
        return self[indexPath.section].getRow(at: indexPath.row)
    }
    
    var rowsCount: Int {
        self.reduce(0, { $0 + $1.rows.count })
    }
    
}