//
//  AddProductsViewModel.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Combine
class AddProductsViewModel: ProductBaseViewModel {
    
    //MARK: - Variables
    let productListState = CurrentValueSubject<ScreenState<[Product]>,Never>(.result([]))
    let newProduct = PassthroughSubject<Product, Never>()
    private let getProductUseCase: GetProductsUseCase
    
    //MARK: - Initialization
    init(getProductUseCase: GetProductsUseCase) {
        self.getProductUseCase = getProductUseCase
    }
    @MainActor
    func fechProducts() {
        productListState.send(.startLoading)
        Task{
            do{
                let result =  try await getProductUseCase.excute()
                productListState.send(.result(result))
            }catch(let error){
                productListState.send(.showMessage(error: error.localizedDescription))
            }
            productListState.send(.stopLoading)
        }
        
    }
}
