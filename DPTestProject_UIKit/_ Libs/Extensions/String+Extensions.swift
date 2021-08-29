import Foundation

extension String {
    
    static func className(_ aClass: AnyClass) -> String {
        NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
    
}
