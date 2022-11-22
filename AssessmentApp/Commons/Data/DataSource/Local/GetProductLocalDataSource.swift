//
//  GetProductLocalDataSource.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation

protocol GetProductLocalDataSourceProtocol{
    func fetchProducts() async throws -> [ProductResponse]
}

class GetProductLocalDataSource: GetProductLocalDataSourceProtocol{
    func fetchProducts() async throws -> [ProductResponse] {
        []
    }

}
