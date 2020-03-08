//
//  TourResponse.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class TourResponse: Codable {
    
    let code : Int
    let message : String
    let tours : [TourVORealm]
    
    init(code: Int, message: String, tours: [TourVORealm]) {
        self.code = code
        self.message = message
        self.tours = tours
    }
    
    enum CodingKeys : String , CodingKey{
        case code = "code"
        case message = "message"
        case tours = "data"
    }
}
