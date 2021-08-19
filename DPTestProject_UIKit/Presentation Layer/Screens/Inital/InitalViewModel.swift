//
//  InitalViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 20.07.2021.
//

import Foundation

protocol InitalViewModelInput: DPViewModelInput {
    var title: String { get }
}

class InitalViewModel: DPViewModel, InitalViewModelInput {
    
    // MARK: - Props
    let title = "DPTestProject_UIKit"
}
