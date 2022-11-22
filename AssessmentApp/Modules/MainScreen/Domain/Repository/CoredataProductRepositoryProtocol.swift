//
//  CoredataProductRepository.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//

import Foundation

protocol CoredataProductRepositoryPrototcol {
    func fetchProducts()  throws -> [Product]
    func addProduct(product: Product) throws
    func updateProduct(product: Product) throws
    func deleteAll() throws
}
