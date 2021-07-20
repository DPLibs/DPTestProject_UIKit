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

protocol InitalViewModelOutput: ViewModelOutput { }

struct InitalViewModel: InitalViewModelInput {
    var output: InitalViewModelOutput?
    
    let title = "title"
}
