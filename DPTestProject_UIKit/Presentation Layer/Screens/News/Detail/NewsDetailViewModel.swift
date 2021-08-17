//
//  NewsDetailViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 17.08.2021.
//

import Foundation

protocol NewsDetailViewModelInput: ViewModelInput {}

protocol NewsDetailViewModelOutput: ViewModelOutput {}

class NewsDetailViewModel: ViewModel, NewsDetailViewModelInput {
    
    // MARK: - Props
    weak var output: NewsDetailViewModelOutput? {
        get {
            self._output as? NewsDetailViewModelOutput
        }
        set {
            self._output = newValue
        }
    }
    
    // MARK: - Methods
}
