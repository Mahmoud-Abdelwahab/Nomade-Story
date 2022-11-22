//
//  GetProductsRepository.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation

protocol GetProductsRepositoryProtocol {
    func fetchRemoteProducts() async throws -> [Product]
}
