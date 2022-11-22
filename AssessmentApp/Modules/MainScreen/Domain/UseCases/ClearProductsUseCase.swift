//
//  ClearProductsUseCase.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//

import Foundation

class ClearProductsUseCase {
    
    private let repository: CoredataProductRepositoryPrototcol
     init(repository: CoredataProductRepositoryPrototcol = CoredataProductRepository()){
         self.repository = repository
     }
     
    func excute() throws  {
        try repository.deleteAll()
     }
}
