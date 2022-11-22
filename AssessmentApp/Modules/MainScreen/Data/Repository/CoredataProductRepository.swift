//
//  CoredataProductRepository.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//

import Foundation

class CoredataProductRepository: CoredataProductRepositoryPrototcol{
    
    private let localDataSrouces: GetProductLocalDataSourceProtocol
    init(localDataSrouces: GetProductLocalDataSourceProtocol = GetProductLocalDataSource()
        ){
        self.localDataSrouces = localDataSrouces
    }

    func fetchProducts()  throws -> [Product] {
        try  localDataSrouces.fetchProducts().map({
            Product(description: $0.description , id: $0.id, imageURL: $0.imageUrl ?? "", name: $0.name ?? "", retailPrice: $0.retailPrice )
        })
    }
    
    
    func addProduct(product: Product) throws {
        try   localDataSrouces.saveProduct(product: product)
    }
    
    func updateProduct(product: Product) throws {
        try localDataSrouces.updateProduct(product: product)
    }
    
    func deleteAll() throws {
        try localDataSrouces.deleteAll()
    }
    
}
