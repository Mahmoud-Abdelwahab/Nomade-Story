//
//  ProductDataSource.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Combine

protocol ProductDataSource {
    func fetchProducts() async throws -> [ProductResponse]
}
