//
//  ProductBaseViewModel.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//

import Foundation
import Combine

protocol ProductBaseViewModel {
    var productListState: CurrentValueSubject<ScreenState<[Product]>,Never> { get }
    func fechProducts()
}
