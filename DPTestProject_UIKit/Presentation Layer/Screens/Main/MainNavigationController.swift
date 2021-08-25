//
//  MainNavigationController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 25.08.2021.
//

import Foundation
import UIKit

protocol MainNavigationControllerInput: DPNavigationControllerInput {}

class MainNavigationController: DPNavigationController {}

extension UIViewController {
    
    var mainNavigationControllerInput: DPNavigationControllerInput? {
        self.navigationController as? DPNavigationControllerInput
    }
    
}
