//
//  GetProductsUseCase.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation

class GetProductsUseCase {
    private let repository: GetProductsRepositoryProtocol
    init(repository: GetProductsRepositoryProtocol = GetProductRepository()){
        self.repository = repository
    }
    
    func excute() async throws -> [Product]{
        return  try await  repository.fetchRemoteProducts()
    }
}
