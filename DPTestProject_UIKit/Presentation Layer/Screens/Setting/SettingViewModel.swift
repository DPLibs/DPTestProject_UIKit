//
//  SettingViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 23.07.2021.
//

import Foundation

protocol SettingViewModelInput: ViewModelInput {
    var title: String { get }
}

protocol SettingViewModelOutput: ViewModelOutput { }

class SettingViewModel: ViewModel, SettingViewModelInput {
    
    // MARK: - Props
    weak var output: SettingViewModelOutput? {
        get {
            self._output as? SettingViewModelOutput
        }
        set {
            self._output = newValue
        }
    }
    
    let title = "titleMain"
    
    // MARK: - Methods
}
