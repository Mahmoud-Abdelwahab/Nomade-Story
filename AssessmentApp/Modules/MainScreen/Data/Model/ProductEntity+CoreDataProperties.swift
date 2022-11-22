//
//  ProductEntity+CoreDataProperties.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var retailPrice: Double
}

extension ProductEntity : Identifiable {

}
