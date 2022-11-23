//
//  Controllable.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 23/11/2022.
//

import Foundation
import Combine

protocol Controllable {
    func bindUI()
    func handleScreenState(state: ScreenState<[Product]>)
    func populateTableViewWith(products: [Product])
    func startLoding()
    func stopLoading()
    func setupTableView()
}


