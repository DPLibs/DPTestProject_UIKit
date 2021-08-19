//
//  SettingViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 23.07.2021.
//

import Foundation

protocol SettingViewModelInput: DPViewModelInput {
    var title: String { get }
}

class SettingViewModel: DPViewModel, SettingViewModelInput {
    
    // MARK: - Props
    let title = "titleMain"
    
    // MARK: - Methods
}
