//
//  InitalViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 20.07.2021.
//

import Foundation

protocol InitalViewModelInput: ViewModelInput {
    var title: String { get }
}

protocol InitalViewModelOutput: ViewModelOutput {}

class InitalViewModel: ViewModel, InitalViewModelInput {
    
    // MARK: - Props
    weak var output: InitalViewModelOutput? {
        get {
            self._output as? InitalViewModelOutput
        }
        set {
            self._output = newValue
        }
    }
    
    let title = "DPTestProject_UIKit"
}
