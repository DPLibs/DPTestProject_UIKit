import Foundation

// MARK: - Section
open class DPTableSection {

    // MARK: - Props
    open var rows: [DPTableRow]
    open var header: DPTableSectionHeader?
    open var footer: DPTableSectionHeader?

    // MARK: - Init
    public init(
        rows: [DPTableRow],
        header: DPTableSectionHeader? = nil,
        footer: DPTableSectionHeader? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }
    
}

public extension DPTableSection {
    
    func getRow(at index: Int) -> DPTableRow? {
        guard self.rows.indices.contains(index) else { return nil }
        
        return self.rows[index]
    }
    
}

// MARK: - Array + DPTableSection
public extension Array where Element == DPTableSection {
    
    var rowsCount: Int {
        self.reduce(0, { $0 + $1.rows.count })
    }
    
    var rowsIsEmpty: Bool {
        self.rowsCount == 0
    }
    
    var headersIsEmpty: Bool {
        self.filter({ $0.header != nil }).isEmpty
    }
    
    var footersIsEmpty: Bool {
        self.filter({ $0.footer != nil }).isEmpty
    }
    
    func getRow(at indexPath: IndexPath) -> DPTableRow? {
        guard self.indices.contains(indexPath.section) else { return nil }
        
        return self[indexPath.section].getRow(at: indexPath.row)
    }
    
}
