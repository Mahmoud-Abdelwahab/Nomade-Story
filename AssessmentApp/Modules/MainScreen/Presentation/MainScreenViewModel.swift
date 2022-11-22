//
//  MainScreenViewModel.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
import Combine

class MainScreenViewModel {
    
    let productListState = CurrentValueSubject<ScreenState<[Product]>,Never>(.result([]))
    private var productList = [Product]()
    private var anyCancelable: Set<AnyCancellable>
    private let addProductUseCase: AddProductToCoreDataUseCase
    private let fetchProductUseCase: FetchProductsUseCase
    private let updateProductUseCase: UpdateProductUseCase
    private let clearProductUseCase: ClearProductsUseCase
    init(){
        self.addProductUseCase    = AddProductToCoreDataUseCase()
        self.fetchProductUseCase  = FetchProductsUseCase()
        self.updateProductUseCase = UpdateProductUseCase()
        self.clearProductUseCase  = ClearProductsUseCase()
        self.anyCancelable        = Set<AnyCancellable>()
    }
    
    @MainActor
    func fechLocatProducts(){
        productListState.send(.startLoading)
        Task{
            do{
              let result = try await fetchProductUseCase.excute()
                self.productList = result
                productListState.send(.result(result))
            }catch(let error){
                productListState.send(.showMessage(error: error.localizedDescription))
            }
            productListState.send(.stopLoading)
        }
       
    }
    
    func isProductLocallyExists(product: Product) -> Bool{
        productList.contains(where: {$0.id == product.id})
    }
    
    func openAddNewProductController() {
        AppCoordinator.shared.openRemotProductListViewController()
            .sink(receiveValue: { [weak self] in
                self?.onGetNewProduct(product: $0)
            }).store(in: &anyCancelable)
    }
    
    func onGetNewProduct(product: Product) {
        if self.isProductLocallyExists(product: product) {
            updateProductInCoreData(product: product)
            updateCurrentList(product: product)
        }else{
            addNewProductToCoreData(product: product)
            addNewProductToCurrentList(product: product)
        }
        productListState.send(.result(productList))
    }

    
    func updateCurrentList(product: Product) {
        if let index =  productList.firstIndex(where: {$0.id == product.id}){
            productList[index].quantity += 1
        }
    }
    
    func addNewProductToCurrentList(product: Product){
        productList.append(product)
    }
    
    func updateProductInCoreData(product: Product){
        do {
            try updateProductUseCase.excute(product: product)
        } catch let error {
            productListState.send(.showMessage(error: error.localizedDescription))
        }
       
    }
    
    func addNewProductToCoreData(product: Product) {
        do {
            try  addProductUseCase.excute(product: product)
        } catch let error {
            productListState.send(.showMessage(error: error.localizedDescription))

        }
    }
    
    func clearAllCoreData(){
        do {
            try  clearProductUseCase.excute()
        } catch let error {
            productListState.send(.showMessage(error: error.localizedDescription))
        }
    }
    
    func clearProductlist(){
        productList.removeAll()
    }
}
