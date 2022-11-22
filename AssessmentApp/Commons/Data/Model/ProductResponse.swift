//
//  ProductResponse.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
// MARK: - ProductResponse
struct ProductResponse: Codable {
    let barcode, description, id: String?
    let imageURL: String?
    let name: String?
    let retailPrice, costPrice: Int?

    enum CodingKeys: String, CodingKey {
        case barcode
        case description
        case id
        case imageURL = "image_url"
        case name
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
    }
}

typealias ProductListResponse = [String: ProductResponse]


