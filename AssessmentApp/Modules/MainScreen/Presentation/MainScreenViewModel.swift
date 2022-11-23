//
//  MainScreenViewModel.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
import Combine

class MainScreenViewModel: ProductBaseViewModel {
    
    let productListState = CurrentValueSubject<ScreenState<[Product]>,Never>(.result([]))
    let recalculateTotalRetailPrice = PassthroughSubject<Void,Never>()
    
    private(set) var productList = [Product]()
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
    func fechProducts(){
        productListState.send(.startLoading)
        Task{
            do{
              let result = try  fetchProductUseCase.excute()
                self.productList = result
                productListState.send(.result(result))
                recalculateTotalRetailPrice.send(())
            }catch(let error){
                productListState.send(.showMessage(error: error.localizedDescription))
            }
            productListState.send(.stopLoading)
        }
       
    }
    
    private func isProductLocallyExists(product: Product) -> Bool{
        productList.contains(where: {$0.id == product.id})
    }
    
    func openAddNewProductController() {
        AppCoordinator.shared.openRemotProductListViewController()
            .sink(receiveValue: { [weak self] in
                self?.onGetNewProduct(product: $0)
            }).store(in: &anyCancelable)
    }
    
    private func onGetNewProduct(product: Product) {
        if self.isProductLocallyExists(product: product) {
            updateProductInCoreData(product: product)
            updateCurrentList(product: product)
        }else{
            addNewProductToCoreData(product: product)
            addNewProductToCurrentList(product: product)
        }
        productListState.send(.result(productList))
        recalculateTotalRetailPrice.send(())
    }

    func totalRetailPrices(productList:  [Product]) -> String {
        var sum = 0.0
        productList.forEach({ product in
            if product.quantity > 1{
                sum  += (product.retailPrice*Double(product.quantity))
            }else{
                sum  += product.retailPrice
            }
        })
        return "Total Retails Price: \(sum) EGP"
    }
    
    private func updateCurrentList(product: Product) {
        if let index =  productList.firstIndex(where: {$0.id == product.id}){
            productList[index].quantity += 1
        }
    }
    
    private func addNewProductToCurrentList(product: Product){
        productList.append(product)
    }
    
    private func updateProductInCoreData(product: Product){
        do {
            try updateProductUseCase.excute(product: product)
        } catch let error {
            productListState.send(.showMessage(error: error.localizedDescription))
        }
       
    }
    
    private func addNewProductToCoreData(product: Product) {
        do {
            try  addProductUseCase.excute(product: product)
        } catch let error {
            productListState.send(.showMessage(error: error.localizedDescription))

        }
    }
    
    private func clearAllCoreData(){
        do {
            try  clearProductUseCase.excute()
        } catch let error {
            productListState.send(.showMessage(error: error.localizedDescription))
        }
    }
    
    private func clearProductlist(){
        productList.removeAll()
    }
    
    func clearAll(){
        clearAllCoreData()
        clearProductlist()
        productListState.send(.result([]))
        recalculateTotalRetailPrice.send(())
    }
    
    func isThereAnyProducts() -> Bool {
        return !productList.isEmpty
    }
    
    func navigateToDetailsController(product: Product) {
        AppCoordinator.shared.navigateToDetails(product: product)
    }
    
}
