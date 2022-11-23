//
//  MainScreenViewModelTests.swift
//  AssessmentAppTests
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//

import XCTest
@testable import AssessmentApp

final class MainScreenViewModelTests: XCTestCase {

    let networkServiceMock = NetworkServiceMock()
    var sut = MainScreenViewModel()
  

    func testNumber_of_mocked_product_is_5() throws {
        let productList  = try!  networkServiceMock.fetchProducts().map({
                    Product(description: $0.value.description ?? "", id: $0.value.id ?? "", imageURL: $0.value.imageURL ?? "", name: $0.value.name ?? "", retailPrice: Double($0.value.retailPrice ?? 0))
                })
        let actual = 5
        let expected = productList.count
        XCTAssertEqual(actual, expected)
    }
    
    func testNumber_total_retail_price_is_2300() throws {
        let productList  = try!  networkServiceMock.fetchProducts().map({
                    Product(description: $0.value.description ?? "", id: $0.value.id ?? "", imageURL: $0.value.imageURL ?? "", name: $0.value.name ?? "", retailPrice: Double($0.value.retailPrice ?? 0))
                })
        
        let actual = "Total Retails Price: 2300.0 EGP"
        let expected = sut.totalRetailPrices(productList: productList)
        XCTAssertEqual(actual, expected)
    }

}
