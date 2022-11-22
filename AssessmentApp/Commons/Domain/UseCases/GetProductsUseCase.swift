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
    
    func excute(isFromRemote: Bool) async throws -> [Product]{
           let remoteResult = try await  repository.fetchRemoteProducts()
           let localResult = try await  repository.fetchLocalProducts()
        return isFromRemote ? remoteResult : localResult
    }
}
