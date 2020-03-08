//
//  TourVO.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class TourVO: Codable {
    var name, tourVODescription, location: String
    var averageRating: Double
    var scoresAndReviews: [ScoresAndReview]
    var photos : [String]

    enum CodingKeys: String, CodingKey {
        case name
        case tourVODescription = "description"
        case location
        case averageRating = "average_rating"
        case scoresAndReviews = "scores_and_reviews"
        case photos = "photos"
    }
    init() {
        self.name = ""
        self.tourVODescription = ""
        self.location = ""
        self.averageRating = 0.0
        self.scoresAndReviews = [ScoresAndReview]()
        self.photos = [String]()
    }
    
    init(name: String, tourVODescription: String, location: String, averageRating: Double, scoresAndReviews: [ScoresAndReview], photos : [String]) {
        self.name = name
        self.tourVODescription = tourVODescription
        self.location = location
        self.averageRating = averageRating
        self.scoresAndReviews = scoresAndReviews
        self.photos = photos
    }
}

// MARK: - ScoresAndReview
class ScoresAndReview: Codable {
    var name: String
    var score: Double
    var maxScore : Int
    var totalReviews: Int

    enum CodingKeys: String, CodingKey {
        case name, score
        case maxScore = "max_score"
        case totalReviews = "total_reviews"
    }
    
    init() {
        self.name = ""
        self.score = 0.0
        self.maxScore = 0
        self.totalReviews = 0
    }
    init(name: String, score: Double, maxScore: Int, totalReviews: Int) {
        self.name = name
        self.score = score
        self.maxScore = maxScore
        self.totalReviews = totalReviews
    }
}
