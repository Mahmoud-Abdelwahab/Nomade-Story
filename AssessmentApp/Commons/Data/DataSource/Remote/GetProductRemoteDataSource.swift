//
//  GetProductRemoteDataSource.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation

protocol GetProductRemoteDataSourceProtocol {
    func fetchProducts() async throws -> ProductListResponse
}

class GetProductRemoteDataSource: GetProductRemoteDataSourceProtocol {
    
    func fetchProducts() async throws -> ProductListResponse {
        guard let url = URL(string: Constants.baseURL)else{   throw APPError.badURL}
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APPError.with("Invalid Response")
        }
        do {
          return try JSONDecoder().decode(ProductListResponse.self, from: data)
        }catch(let error){
            throw APPError.with(error.localizedDescription)
        }
    }
}
