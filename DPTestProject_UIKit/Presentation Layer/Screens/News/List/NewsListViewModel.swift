//
//  NewsListViewModel.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 16.08.2021.
//

import Foundation

protocol NewsListViewModelInput: DPViewModelInput {
    var didGetList: (([String]) -> Void)? { get set }
    
    func getList()
}

class NewsListViewModel: DPViewModel, NewsListViewModelInput {
    
    // MARK: - Props
    var didGetList: (([String]) -> Void)?
    
    // MARK: - Methods
    func getList() {
        var lists: [String] {
            var result: [String] = []
            
            for i in 0...10 {
                result += [i.description]
            }
            
            return result
        }
        
        self.didGetList?(lists)
    }
}
