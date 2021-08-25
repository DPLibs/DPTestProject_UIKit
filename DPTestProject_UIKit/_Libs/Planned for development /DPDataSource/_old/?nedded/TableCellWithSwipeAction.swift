////
////  TableCellWithSwipeAction.swift
////  giberno
////
////  Created by mac mini on 22.12.2020.
////
//
//import Foundation
//import GKRepresentable
//
//class TableCellWithSwipeAction: TableCell {
//    
//    public var didBeginEdit: ((UITableViewCell) -> Void)?
//    public var didEndEdit: ((UITableViewCell) -> Void)?
//    
//    private var swipeGesturesForAction: [UISwipeGestureRecognizer] = []
//    
//    func setEdited(_ isEdit: Bool) {}
//    
//    public var withSwipeAction: Bool = false {
//        didSet {
//            if self.withSwipeAction {
//                self.appendSwipeGesturesForAction()
//            } else {
//                self.removeSwipeGesturesForAction()
//            }
//        }
//    }
//    
//    private func appendSwipeGesturesForAction() {
//        self.removeSwipeGesturesForAction()
//        
//        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleAppendSwipeGestureForEditable(_:)))
//        leftGesture.direction = .left
//        self.addGestureRecognizer(leftGesture)
//        
//        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleAppendSwipeGestureForEditable(_:)))
//        rightGesture.direction = .right
//        self.addGestureRecognizer(rightGesture)
//        
//        self.swipeGesturesForAction.append(contentsOf: [leftGesture, rightGesture])
//    }
//    
//    private func removeSwipeGesturesForAction() {
//        self.swipeGesturesForAction.forEach({ self.removeGestureRecognizer($0) })
//    }
//    
//    @objc
//    private func handleAppendSwipeGestureForEditable(_ gesture: UISwipeGestureRecognizer) {
//        guard self.withSwipeAction else { return }
//        switch gesture.direction {
//        case .left:
//            self.didBeginEdit?(self)
//        case .right:
//            self.didEndEdit?(self)
//        default:
//            return
//        }
//    }
//    
//}

//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let model = self.sections.row(at: indexPath),
//            !model.cellIdentifier.isEmpty,
//            let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? TableCell
//        else { return UITableViewCell() }
//        cell.model = model
//
//        if let cellWithSwipeAction = cell as? TableCellWithSwipeAction {
//            cellWithSwipeAction.didBeginEdit = { cellBeginEdit in
//                tableView.visibleCells.forEach({ cellEndEdit in
//                    if cellEndEdit != cellBeginEdit {
//                        (cellEndEdit as? TableCellWithSwipeAction)?.setEdited(false)
//                    } else {
//                        (cellEndEdit as? TableCellWithSwipeAction)?.setEdited(true)
//                    }
//                })
//            }
//            cellWithSwipeAction.didEndEdit = { cellEndEdit in
//                (cellEndEdit as? TableCellWithSwipeAction)?.setEdited(false)
//            }
//        }
//
//        self.outputUI?.cellForRowAt(adapter: self, at: indexPath, cell: cell)
//        return cell
//    }
