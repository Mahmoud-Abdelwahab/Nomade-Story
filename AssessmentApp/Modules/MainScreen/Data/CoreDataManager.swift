//
//  CoreDataManager.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol{
    func fetchProducts() throws -> [ProductEntity]
    func addProduct(product: Product) throws
    func updateProduct(product: Product) throws
    func deleteAll() throws
}

class CoreDataManager : CoreDataManagerProtocol{
    
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
    
    func addProduct(product: Product) throws {
        let productEntity = ProductEntity(context: context)
        productEntity.name = product.name
        productEntity.id   = product.id
        productEntity.imageUrl = product.imageURL
        productEntity.retailPrice = product.retailPrice
        productEntity.desc = product.description
        productEntity.quantity = Int16(product.quantity)
        try saveContext()
    }
    
    func fetchProducts() throws -> [ProductEntity] {
        return try context.fetch(ProductEntity.fetchRequest())
    }
    
    func updateProduct(product: Product) throws {
        let fetchedProduct: ProductEntity!
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", product.id)
        let results = try? context.fetch(fetchRequest)
        if results?.count != 0 {
            fetchedProduct = results?.first
            fetchedProduct.quantity = fetchedProduct.quantity + 1
        }
        try saveContext()
    }
    
    func deleteAll() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ProductEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(batchDeleteRequest)
    }
    
    
    func saveContext() throws{
        do {
            try context.save()
        } catch let error {
            throw error
        }
    }
}
