//
//  CountryResponse.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 04/03/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

// MARK: - CountryResponse
class CountryResponse: Codable {
    let code: Int
    let message: String
    let countries: [CountryVORealm]

    init(code: Int, message: String, countries: [CountryVORealm]) {
        self.code = code
        self.message = message
        self.countries = countries
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case countries = "data"
    }
}
