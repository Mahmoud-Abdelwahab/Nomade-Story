//
//  AddProductToCoreDataUseCase.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//

import Foundation
class AddProductToCoreDataUseCase {
    
    private let repository: CoredataProductRepositoryPrototcol
     init(repository: CoredataProductRepositoryPrototcol = CoredataProductRepository()){
         self.repository = repository
     }
     
    func excute(product: Product) throws {
        try repository.addProduct(product: product)
     }
}
