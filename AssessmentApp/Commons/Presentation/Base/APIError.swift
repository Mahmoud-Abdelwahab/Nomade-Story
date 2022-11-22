//
//  APPError.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import Foundation
// MARK: - APPError Errors

public enum APPError: Error {
    case decodingError
    case with(String)
    case connectionError
    case badURL
    
    var message: String {
        switch self {
        case .with(let error):
            return error
        case .badURL:
            return "bad URL"
        case .decodingError:
            return "Decoding Error ..."
        case .connectionError:
            return "Please check your internet connection"
        }
    }
}
