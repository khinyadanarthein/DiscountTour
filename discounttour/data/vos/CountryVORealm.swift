//
//  CountryVO.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 04/03/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Datum
class CountryVORealm: Object, Codable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var conDescription: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var averageRating: Double = 0.0
    var countryScoresAndReviews : List<CountryScoresAndReview> = List<CountryScoresAndReview>()
    var photos : List<String> = List<String>()
    
    override static func primaryKey() -> String? {
        return "location"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case conDescription = "description"
        case location
        case averageRating = "average_rating"
        case countryScoresAndReviews = "scores_and_reviews"
        case photos
    }
}

// MARK: - ScoresAndReview
class CountryScoresAndReview: Object, Codable {
    @objc dynamic var  name : String = ""
    @objc dynamic var  score: Double = 0.0
    @objc dynamic var  maxScore : Int = 0
    @objc dynamic var  totalReviews: Int = 0

    enum CodingKeys: String, CodingKey {
        case name, score
        case maxScore = "max_score"
        case totalReviews = "total_reviews"
    }

//    init(name: String, score: Double, maxScore: Int, totalReviews: Int) {
//        self.name = name
//        self.score = score
//        self.maxScore = maxScore
//        self.totalReviews = totalReviews
//    }
}

enum Name: String, Codable {
    case booking = "Booking"
    case hotelOut = "Hotel Out"
}
