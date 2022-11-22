//
//  GetProductsUseCase.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation

class GetRemoteProductsUseCase {
    let repository: GetProductsRepositoryProtocol
    init(repository: GetProductsRepositoryProtocol = GetProductRepository()){
        self.repository = repository
    }
    
    func excute() async throws -> [Product]{
      try await  repository.fetchRemoteProducts()
    }
}
