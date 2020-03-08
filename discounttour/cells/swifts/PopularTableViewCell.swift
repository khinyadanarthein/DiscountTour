//
//  PopularTableViewCell.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 21/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import Kingfisher

class PopularTableViewCell: UITableViewCell {
    
    static var identifier : String {
        return "PopularTableViewCell"
    }

    @IBOutlet weak var imageViewTourPhoto: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var imageViewStar: UIImageView!
    
    
    var countryData = CountryVORealm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewTourPhoto.layer.masksToBounds = true
        imageViewTourPhoto.layer.cornerRadius = 10
        imageViewTourPhoto.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        viewRating.layer.masksToBounds = true
        viewRating.layer.cornerRadius = 10
        viewRating.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data : TourVORealm? {
        didSet{
            labelName.text = data?.name
            labelDescription.text = data?.tourVODescription
            labelRate.text = "\(data?.averageRating ?? 0)"
            imageViewTourPhoto.kf.setImage(with: URL(string: data?.photos.first ?? ""))
            
        }
    }
    
}
