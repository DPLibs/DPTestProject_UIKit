//
//  NewsListViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 16.08.2021.
//

import Foundation

protocol NewsListViewModelInput: ViewModelInput {
    func getList()
}

protocol NewsListViewModelOutput: ViewModelOutput {
    func provideGetList(_ model: NewsListViewModelInput, lists: [String])
}

class NewsListViewModel: ViewModel, NewsListViewModelInput {
    
    // MARK: - Props
    weak var output: NewsListViewModelOutput? {
        get {
            self._output as? NewsListViewModelOutput
        }
        set {
            self._output = newValue
        }
    }
    
    // MARK: - Methods
    func getList() {
        var lists: [String] {
            var result: [String] = []
            
            for i in 0...100 {
                result += [i.description]
            }
            
            return result
        }
        
        self.output?.provideGetList(self, lists: lists)
    }
}
