//
//  ViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 20.07.2021.
//

import Foundation

public protocol ViewModelInput {
    var _output: ViewModelOutput? { get set }
}

public protocol ViewModelOutput: AnyObject { }

open class ViewModel: ViewModelInput {
    
    // MARK: - Props
    weak open var _output: ViewModelOutput?
    
}
