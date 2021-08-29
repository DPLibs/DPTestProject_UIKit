////
////  TableCellFirstRespondable.swift
////  giberno
////
////  Created by mac mini on 09.12.2020.
////
//
//import Foundation
//import UIKit
//
//protocol TableCellFirstRespondable {
//    func setupBecomeFirstResponder()
//}
//
//extension UITableView {
//    
//    func setupBecomeFirstResponderFirstFindCell() {
//        guard let cell = self.visibleCells.first(where: { $0 is TableCellFirstRespondable }) as? TableCellFirstRespondable else { return }
//        cell.setupBecomeFirstResponder()
//    }
//}
