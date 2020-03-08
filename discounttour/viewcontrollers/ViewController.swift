//
//  ViewController.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 21/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewHome: UITableView!
    
    
    var tourData: [TourVORealm] = []{
        didSet{
            //self.collectionViewNews.reloadData()
            self.tableViewHome.reloadData()
        }
    }
    
    var countryData: [CountryVORealm] = []{
        didSet{
            self.tableViewHome.reloadData()
        }
    }
    
    let disposebag :DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        
        //TODO: - register cells
        tableViewHome.register(UINib(nibName: MainTitleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MainTitleTableViewCell.identifier)
        
        tableViewHome.register(UINib(nibName: CountryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CountryTableViewCell.identifier)
        
        tableViewHome.register(UINib(nibName: PopularTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PopularTableViewCell.identifier)
 
        TourModel.shared.getCountriesAndTours()
        
        TourModel.shared.getToursObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ toursList in
                self.tourData = toursList
            })
            .disposed(by: disposebag)
        
        TourModel.shared.getCountriesObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ countriesList in
                self.countryData = countriesList
            })
            .disposed(by: disposebag)
        
    }
    
    
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        let popular = tourData[indexPath.row]
        let detailData = TourVO()
        detailData.name = popular.name
        detailData.location = popular.location
        detailData.tourVODescription = popular.tourVODescription
        detailData.averageRating = popular.averageRating
        
        var scoreList = [ScoresAndReview]()
        for data in popular.scoresAndReviews {
            let score = ScoresAndReview()
            score.name = data.name
            score.maxScore = data.maxScore
            score.score = data.score
            score.totalReviews = data.totalReviews
            scoreList.append(score)
        }
        detailData.scoresAndReviews = scoreList
        detailData.photos = popular.photos.map { (photoUrl) -> String in
            return photoUrl
        }
         
        detailVC.detailData = detailData
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return self.tourData.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let titleCell = tableView.dequeueReusableCell(withIdentifier: MainTitleTableViewCell.identifier, for: indexPath) as? MainTitleTableViewCell {
                return titleCell
            }
            
        case 1:
            if let countryCell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell {
                countryCell.setData(countryData: self.countryData)
                countryCell.delegate = self
                return countryCell
            }
            
        case 2:
            if let popularCell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.identifier, for: indexPath) as? PopularTableViewCell {
                popularCell.data = self.tourData[indexPath.row]
                return popularCell
            }
        default :
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CGFloat(60.0)
        case 1:
            return CGFloat(280.0)
        case 2:
            return CGFloat(100.0)
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70.0)) //set these values as necessary
            returnedView.backgroundColor = .white

            let label = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.width, height: 25.0))

            label.text = "Popular Tour"
            returnedView.addSubview(label)

            return returnedView
        }
        return UIView()
    }
}

extension ViewController : CollectionSelectDelegate {
    func tappedCountry(data: CountryVORealm) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        let popular = data
        let detailData = TourVO()
        detailData.name = popular.name
        detailData.location = popular.location
        detailData.tourVODescription = popular.conDescription
        detailData.averageRating = popular.averageRating
        
        var scoreList = [ScoresAndReview]()
        for data in popular.countryScoresAndReviews {
            let score = ScoresAndReview()
            score.name = data.name
            score.maxScore = data.maxScore
            score.score = data.score
            score.totalReviews = data.totalReviews
            scoreList.append(score)
        }
        detailData.scoresAndReviews = scoreList
        detailData.photos = popular.photos.map { (photoUrl) -> String in
            return photoUrl
        }
         
        detailVC.detailData = detailData
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
