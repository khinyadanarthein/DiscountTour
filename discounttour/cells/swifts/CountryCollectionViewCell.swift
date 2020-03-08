//
//  CountryCollectionViewCell.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 22/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewTour: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTourCount: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var imageRatingStar: UIImageView!
    
    static var identifier : String {
        return "CountryCollectionViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewTour.layer.masksToBounds = true
        imageViewTour.layer.cornerRadius = 15
    }
    var data : CountryVORealm? {
        didSet{
            labelName.text = data?.name
            var tours = 0
            for data in data!.countryScoresAndReviews {
                tours = tours + data.maxScore
            }
            labelTourCount.text = "\(tours) Tours"
            labelRating.text = "\(data?.averageRating ?? 0)"
            imageViewTour.kf.setImage(with: URL(string: data?.photos.first ?? ""))
            
        }
    }
    
}
