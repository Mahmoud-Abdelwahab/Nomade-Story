//
//  NetworkServiceMock.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import Foundation

// You may use this URL to load data similar to that which is present in DemoData.swift
let demoDataURL = URL(string: "https://run.mocky.io/v3/4e23865c-b464-4259-83a3-061aaee400ba")!

#warning("Build an actual working service that can fetch the model entities. You may start out with the mock data provided here.")
// Until you have built out your network service, you can use the mock
// response provided here:
class NetworkServiceMock: ProductDataSource {
    func fetchProducts() async throws -> [ProductResponse] {
        let data = Data(demoData.utf8)
        let result = try! JSONDecoder().decode([ProductResponse].self, from: data)
        return result
    }
}
