//
//  FetchProductsUseCase.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//


import Foundation
class FetchProductsUseCase {
    
    private let repository: CoredataProductRepositoryPrototcol
     init(repository: CoredataProductRepositoryPrototcol = CoredataProductRepository()){
         self.repository = repository
     }
     
    func excute() throws -> [Product] {
        try repository.fetchProducts()
     }
}
