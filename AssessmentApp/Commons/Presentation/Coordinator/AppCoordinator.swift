//
//  AppCoordinator.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit
import Combine

class AppCoordinator {
    
    static let shared = AppCoordinator()
    var navigationController: UINavigationController?
    let window: UIWindow

    private init() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let mainControllerViewController = MainScreenViewController(viewModel: MainScreenViewModel())
        navigationController = UINavigationController(rootViewController: mainControllerViewController)
        navigationController?.isNavigationBarHidden = false
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func openRemotProductListViewController() -> AnyPublisher<Product,Never>{
        let publisher = PassthroughSubject<Product, Never>()
        let addNewProductViewController = AddNewProductViewController(viewModel: AddProductsViewModel(getProductUseCase: GetProductsUseCase()), dataSource: ProductsTableViewDataSource(selectedProduct: { product in
            publisher.send(product)
        }))
        navigationController?.pushViewController(addNewProductViewController, animated: true)
        return publisher.eraseToAnyPublisher()
    }
    
    func navigateToDetails() {
      
    }
    
}
