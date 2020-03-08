//
//  DetailPhotoCollectionViewCell.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 05/03/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class DetailPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewDetail: UIImageView!
    static var identifier : String {
        return "DetailPhotoCollectionViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewDetail.layer.masksToBounds = true
        imageViewDetail.layer.cornerRadius = 10
    }

}
