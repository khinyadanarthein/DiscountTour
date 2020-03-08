//
//  CountryTableViewCell.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 21/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    static var identifier : String {
        return "CountryTableViewCell"
    }
    
    var delegate : CollectionSelectDelegate!

    @IBOutlet weak var collectionViewMain: UICollectionView!
    
    public var countryData: [CountryVORealm] = []{
        didSet{
            self.collectionViewMain.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewMain.register(UINib(nibName: CountryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
        
        collectionViewMain.dataSource = self
        collectionViewMain.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(countryData : [CountryVORealm]) {
        self.countryData = countryData
    }
}

extension CountryTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as? CountryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.countryData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
}
extension CountryTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.tappedCountry(data: self.countryData[indexPath.row])
    }
}

protocol CollectionSelectDelegate {
    func tappedCountry(data : CountryVORealm)
}

