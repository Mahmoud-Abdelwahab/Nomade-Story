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
        let pro: ProductEntity!

        let fetchUser: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        fetchUser.predicate = NSPredicate(format: "id = %@", product.id)

        let results = try? context.fetch(fetchUser)

        if results?.count != 0 {
            pro = results?.first
            pro.quantity = pro.quantity + 1
        }
//
//       {
//               if fetchResults.count != 0{
//
//                   var managedObject = fetchResults[0]
//                   managedObject.setValue(accessToken, forKey: "accessToken")
//
//                   context.save(nil)
//               }
//           }
//
       try saveContext()
    }
    
    func deleteAll() throws {
        
    }
    
    
    func saveContext() throws{
        do {
            try context.save()
        } catch let error {
            throw error
        }
    }
}
