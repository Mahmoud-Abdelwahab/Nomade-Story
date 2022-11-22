//
//  AppCoordinator.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit

class AppCoordinator {
    
    static let shared = AppCoordinator()
    var navigationController: UINavigationController?
    let window: UIWindow

    private init() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let mainControllerViewController = MainScreenViewController()
        navigationController = UINavigationController(rootViewController: mainControllerViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
    func navigateToDetails() {
      
    }
    
}
