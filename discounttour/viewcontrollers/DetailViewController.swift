//
//  DetailViewController.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageViewTourPhoto: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    @IBOutlet weak var viewMainBack: UIView!
    @IBOutlet weak var viewIconBack: UIView!
    @IBOutlet weak var viewSandBeachBack: UIView!
    @IBOutlet weak var viewCoastBack: UIView!
    @IBOutlet weak var viewBarBack: UIView!
    @IBOutlet weak var labelBookingRate: UILabel!
    @IBOutlet weak var labelHotelRate: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelReviewCount1: UILabel!
    
    @IBOutlet weak var labelDescription2: UILabel!
    @IBOutlet weak var collectionViewFooterList: UICollectionView!
    @IBOutlet weak var labelDetailText: UILabel!
    @IBOutlet weak var labelReviewCount2: UILabel!
    
    @IBOutlet weak var viewBook: UIView!
    @IBOutlet weak var viewHotel: UIView!
    @IBOutlet weak var viewIconBook: UIView!
    @IBOutlet weak var viewIconHotel: UIView!
    static var identifier : String {
        return "DetailViewController"
    }
    
    var detailData : TourVO!
    
    var photoList : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialization code
        collectionViewFooterList.register(UINib(nibName: DetailPhotoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DetailPhotoCollectionViewCell.identifier)
        
        collectionViewFooterList.dataSource = self
        collectionViewFooterList.delegate = self
        self.viewMainBack.layer.masksToBounds = true
        self.viewMainBack.layer.cornerRadius = 26
        self.viewIconBack.layer.masksToBounds = true
        self.viewIconBack.layer.cornerRadius = 26
        self.viewSandBeachBack.layer.masksToBounds = true
        self.viewSandBeachBack.layer.cornerRadius = 26
        self.viewCoastBack.layer.masksToBounds = true
        self.viewCoastBack.layer.cornerRadius = 26
        self.viewBarBack.layer.masksToBounds = true
        self.viewBarBack.layer.cornerRadius = 26
        
        self.viewBook.layer.masksToBounds = true
        self.viewBook.layer.cornerRadius = 15
        self.viewHotel.layer.masksToBounds = true
         self.viewHotel.layer.cornerRadius = 15
        
        self.viewIconBook.layer.masksToBounds = true
        self.viewIconBook.layer.cornerRadius = 15
        self.viewIconHotel.layer.masksToBounds = true
         self.viewIconHotel.layer.cornerRadius = 15
        
        
        setData()
    }
    
    func setData() {
        
        self.labelName.text = detailData.name
        self.labelLocation.text = detailData.location
        self.labelRating.text = "\(detailData.averageRating)"
        self.labelDetailText.text = detailData.tourVODescription
        
        self.labelDescription.text = self.detailData.scoresAndReviews[0].name
        
        let score1 = "\(detailData.scoresAndReviews[0].score)/\(detailData.scoresAndReviews[0].maxScore)"
        self.labelBookingRate.text = score1
        
        self.labelReviewCount1.text = "Base on \(detailData.scoresAndReviews[0].totalReviews) reivews"
        
        let score2 = "\(detailData.scoresAndReviews[1].score)/\(detailData.scoresAndReviews[1].maxScore)"
        self.labelHotelRate.text = score2
        
        self.labelReviewCount2.text = "Base on \(detailData.scoresAndReviews[1].totalReviews) reivews"
        
        self.photoList = detailData.photos
        self.imageViewTourPhoto.kf.setImage(with: URL(string: self.photoList.first!))
        
        
        self.collectionViewFooterList.reloadData()
    }

}

extension DetailViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPhotoCollectionViewCell.identifier, for: indexPath) as? DetailPhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageViewDetail.kf.setImage(with: URL(string: self.photoList[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
}
extension DetailViewController : UICollectionViewDelegate {
    
}
