//
//  MainScreenViewModel.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
import Combine

class MainScreenViewModel {
    private(set) var selectedProduct: Product?
    private var anyCancelable: Set<AnyCancellable>

    init(){
        self.anyCancelable = Set<AnyCancellable>()
    }
    
    func openAddNewProductController() {
        AppCoordinator.shared.openRemotProductListViewController()
            .sink(receiveValue: { [weak self] in
                self?.selectedProduct = $0
                print($0)
            }).store(in: &anyCancelable)
    }
}
