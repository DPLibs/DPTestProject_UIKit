//
//  MainViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 23.07.2021.
//

import Foundation

protocol MainViewModelInput: ViewModelInput {
    var title: String { get }
}

protocol MainViewModelOutput: ViewModelOutput { }

class MainViewModel: ViewModel, MainViewModelInput {
    
    // MARK: - Props
    weak var output: MainViewModelOutput? {
        get {
            self._output as? MainViewModelOutput
        }
        set {
            self._output = newValue
        }
    }
    
    let title = "titleMain"
    
    // MARK: - Methods
}
