//
//  CoreDataManager.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init(){}
    
     func saveProdcut(product: Product) throws {
        let productEntity = ProductEntity(context: context)
         productEntity.name = product.name
         productEntity.id   = product.id
         productEntity.imageUrl = product.imageURL
         productEntity.retailPrice = product.retailPrice
         productEntity.desc = product.description
         productEntity.quantity = Int16(product.quantity)
         try save()
    }
    
    func fetchProducts() throws -> [ProductEntity] {
        return try context.fetch(ProductEntity.fetchRequest())
    }
    
    func save() throws{
        do {
            try context.save()
        } catch let error {
            throw error
        }
    }
}
