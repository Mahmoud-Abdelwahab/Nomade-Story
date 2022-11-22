//
//  GetProductRepository.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
class GetProductRepository: GetProductsRepositoryProtocol{
    
    private let remoteDataSource: GetProductRemoteDataSourceProtocol
    private let localDataSrouces: GetProductLocalDataSourceProtocol
    init(
        remoteDataSource: GetProductRemoteDataSourceProtocol = GetProductRemoteDataSource(),
        localDataSrouces: GetProductLocalDataSourceProtocol = GetProductLocalDataSource()
    ){
        self.remoteDataSource = remoteDataSource
        self.localDataSrouces = localDataSrouces
    }
    
    func fetchRemoteProducts() async throws -> [Product] {
        try await remoteDataSource.fetchProducts().map({
            Product(description: $0.value.description ?? "", id: $0.value.id ?? "", imageURL: $0.value.imageURL ?? "", name: $0.value.name ?? "", retailPrice: $0.value.retailPrice ?? 0)
        })
    }
    
    func fetchLocalProducts() async throws -> [Product] {
        try await localDataSrouces.fetchProducts().map({
            Product(description: $0.description ?? "", id: $0.id ?? "", imageURL: $0.imageURL ?? "", name: $0.name ?? "", retailPrice: $0.retailPrice ?? 0)
        })
    }
    
    
}


