//
//  GetProductsRepository.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation

protocol GetProductsRepository {
    func fetchProducts() async throws -> [Product]
}
