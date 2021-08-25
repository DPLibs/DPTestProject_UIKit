////
////  EqualIdentifiable.swift
////  DPDataSource
////
////  Created by mac mini on 14.04.2021.
////
//
//import Foundation
//
//public protocol EqualIdentifiable {
//    var identifier: String { get set }
//    
//    func isEqualIdentifier(to another: EqualIdentifiable) -> Bool
//}
//
//public extension EqualIdentifiable {
//    
//    func isEqualIdentifier(to another: EqualIdentifiable) -> Bool {
//        guard !self.identifier.isEmpty, !another.identifier.isEmpty else { return false }
//        
//        return self.identifier == another.identifier
//    }
//    
//}
//
//public extension EqualIdentifiable where Self: Equatable {
//    
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        guard !lhs.identifier.isEmpty, !rhs.identifier.isEmpty else { return false }
//        
//        return lhs.identifier == rhs.identifier
//    }
//    
//}
