//
//  ProductRemoteDataSource.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
class ProductRemoteDataSource: ProductDataSource {
    
    func fetchProducts() async throws -> [ProductResponse] {
        guard let url = URL(string: Constants.baseURL)else{   throw APPError.badURL}
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APPError.with("Invalid Response")
        }
        do {
          return try JSONDecoder().decode([ProductResponse].self, from: data)
        }catch{
            throw APPError.decodingError
        }
    }
}
