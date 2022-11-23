//
//  NetworkServiceMock.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import Foundation


class NetworkServiceMock: GetProductRemoteDataSourceProtocol {
    func fetchProducts()  throws -> ProductListResponse {
        let data = Data(demoData.utf8)
        let result = try! JSONDecoder().decode(ProductListResponse.self, from: data)
        return result
    }
}
