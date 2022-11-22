//
//  ScreenState.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation

enum ScreenState<T>{
    case startLoading
    case stopLoading
    case result(T)
    case showMessage(error:String)
}
