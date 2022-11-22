//
//  AddProductsViewModel.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Combine
class AddProductsViewModel {
    
    let productListState = CurrentValueSubject<ScreenState<[Product]>,Never>(.result([]))
    
    private let getProductUseCase: GetProductsUseCase
    init(getProductUseCase: GetProductsUseCase) {
        self.getProductUseCase = getProductUseCase
    }
    @MainActor
    func getProductList() {
        productListState.send(.startLoading)
        Task{
            do{
             let result =  try await getProductUseCase.excute(isFromRemote: true)
                productListState.send(.result(result))
            }catch(let error){
                productListState.send(.showMessage(error: error.localizedDescription))
            }
        }
        productListState.send(.stopLoading)
    }
}
