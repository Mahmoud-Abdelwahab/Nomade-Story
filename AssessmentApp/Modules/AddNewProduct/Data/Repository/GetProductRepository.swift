//
//  GetProductRepository.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
class GetProductRepository: GetProductsRepositoryProtocol{
    
    private let remoteDataSource: GetProductRemoteDataSourceProtocol
    init(
        remoteDataSource: GetProductRemoteDataSourceProtocol = GetProductRemoteDataSource()
    ){
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchRemoteProducts() async throws -> [Product] {
        try await remoteDataSource.fetchProducts().map({
            Product(description: $0.value.description ?? "", id: $0.value.id ?? "", imageURL: $0.value.imageURL ?? "", name: $0.value.name ?? "", retailPrice: Double($0.value.retailPrice ?? 0))
        })
    }
    
}


