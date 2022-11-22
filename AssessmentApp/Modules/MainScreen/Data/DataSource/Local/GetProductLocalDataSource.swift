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
    func saveProduct(product: Product) throws
    func updateProduct(product: Product) throws
    func deleteAll() throws
}

class GetProductLocalDataSource: GetProductLocalDataSourceProtocol{

    func fetchProducts() throws -> [ProductEntity] {
        return try CoreDataManager.shared.fetchProducts()
    }
    
    func saveProduct(product: Product) throws {
      try  CoreDataManager.shared.saveProdcut(product: product)
    }
    
    func updateProduct(product: Product) throws {
        
    }
    
    func deleteAll() throws {
        
    }

}
