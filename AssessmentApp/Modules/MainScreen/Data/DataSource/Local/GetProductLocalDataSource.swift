//
//  GetProductLocalDataSource.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import CoreData
import UIKit

protocol GetProductLocalDataSourceProtocol{
    func fetchProducts() throws -> [ProductEntity]
    func addProduct(product: Product) throws
    func updateProduct(product: Product) throws
    func deleteAll() throws
}

class GetProductLocalDataSource: GetProductLocalDataSourceProtocol{
    
    func fetchProducts() throws -> [ProductEntity] {
        return try CoreDataManager.shared.fetchProducts()
    }
    
    func addProduct(product: Product) throws {
        try  CoreDataManager.shared.addProduct(product: product)
    }
    
    func updateProduct(product: Product) throws {
        try CoreDataManager.shared.updateProduct(product: product)
    }
    
    func deleteAll() throws {
        try CoreDataManager.shared.deleteAll()
    }
    
}
