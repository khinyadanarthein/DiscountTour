//
//  TourVORealm.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

class TourVORealm: Object , Codable {
    @objc dynamic var name : String = ""
    @objc dynamic var tourVODescription : String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var averageRating: Double = 0.0
    var scoresAndReviews : List<ScoresAndReviewVORealm> = List<ScoresAndReviewVORealm>()
    var photos : List<String> = List<String>()

    override static func primaryKey() -> String? {
        return "location"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case tourVODescription = "description"
        case location
        case averageRating = "average_rating"
        case scoresAndReviews = "scores_and_reviews"
        case photos
    }
}

// MARK: - ScoresAndReview
class ScoresAndReviewVORealm: Object , Codable{
    @objc dynamic var name: String = ""
    @objc dynamic var score: Double = 0.0
    @objc dynamic var maxScore: Int=0
    @objc dynamic var totalReviews: Int=0
    
    enum CodingKeys: String, CodingKey {
        case name, score
        case maxScore = "max_score"
        case totalReviews = "total_reviews"
    }

}
