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
        let mainControllerViewController = MainScreenViewController(viewModel: MainScreenViewModel(), dataSource: ProductsTableViewDataSource())
        navigationController = UINavigationController(rootViewController: mainControllerViewController)
        navigationController?.isNavigationBarHidden = false
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func openRemotProductListViewController() -> AnyPublisher<Product,Never>{
        let viewModel =  AddProductsViewModel(getProductUseCase: GetProductsUseCase())
        let addNewProductViewController = AddNewProductViewController(viewModel: viewModel, dataSource: ProductsTableViewDataSource())
        navigationController?.pushViewController(addNewProductViewController, animated: true)
        return viewModel.newProduct.eraseToAnyPublisher()
    }
    
    func navigateToDetails(product: Product) {
        let detailsViewController = DetailsViewController()
        detailsViewController.product = product
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
