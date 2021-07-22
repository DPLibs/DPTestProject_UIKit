//
//  InitalViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 20.07.2021.
//

import Foundation

protocol InitalViewModelInput: ViewModelInput {
    var title: String { get }
    
    func loadTitle()
}

protocol InitalViewModelOutput: ViewModelOutput {
    func provideLoadTitle(_ model: InitalViewModelInput)
}

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
    
    weak var controller: InitalViewControllerInput? {
        get {
            self._controller as? InitalViewControllerInput
        }
        set {
            self._controller = newValue
        }
    }
    
    let title = "title"
    
    // MARK: - Methods
    func loadTitle() {
        self.output?.provideLoadTitle(self)
    }
}
