//
//  File.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

class TourModel {
    
    public static let shared : TourModel = TourModel()
    
    private init() {}
    
    let disposebag = DisposeBag()
    
    func getAllTours(success: @escaping (Observable<[TourVORealm]>) -> Void, failure : @escaping (String) -> Void) {
        
        ApiClient.shared.getAllTours(success: { (tours) in
            
            let tourList = tours.map { (tour) -> TourVORealm in
                
                let tourRealm = TourVORealm()
                tourRealm.name = tour.name
                tourRealm.location = tour.location
                tourRealm.tourVODescription = tour.tourVODescription
                tourRealm.averageRating = tour.averageRating
                tourRealm.scoresAndReviews = tour.scoresAndReviews
                tourRealm.photos = tour.photos
                
                return tourRealm
            }
            
            print(tourList.count)
            RealmHelper.shared.saveTours(tours: tourList, success: { (toursRealm) in
                //success(newsList)
                success(RealmHelper.shared.retrieveTours())
                
            }) { (message) in
                failure(message)
                success(RealmHelper.shared.retrieveTours())
            }
            
        }) { (message) in
            print("Network error -> \(message)")
            //success()
            success(RealmHelper.shared.retrieveTours())
        }
    }
    
    func getAllToursN(success: @escaping ([TourVORealm]) -> Void, failure : @escaping (String) -> Void) {
        
        ApiClient.shared.getAllTours(success: { (tours) in
            
            let tourList = tours.map { (tour) -> TourVORealm in
                
                let tourRealm = TourVORealm()
                tourRealm.name = tour.name
                tourRealm.location = tour.location
                tourRealm.tourVODescription = tour.tourVODescription
                tourRealm.averageRating = tour.averageRating
                tourRealm.scoresAndReviews = tour.scoresAndReviews
                tourRealm.photos = tour.photos
                
                return tourRealm
            }
            
            print(tourList.count)
            RealmHelper.shared.saveTours(tours: tourList, success: { (toursRealm) in
                success(tourList)
                //success(RealmHelper.shared.retrieveToursN())
                
            }) { (message) in
                //success(tourList)
                success(RealmHelper.shared.retrieveToursN())
            }
            
        }) { (message) in
            print("Network error -> \(message)")
            //success()
            success(RealmHelper.shared.retrieveToursN())
        }
    }
    
    
    func getAllCountries(success: @escaping (Observable<[CountryVORealm]>) -> Void, failure : @escaping (String) -> Void) {
        
        ApiClient.shared.getAllCountries(success: { (countries) in
            
            let countryList = countries.map { (country) -> CountryVORealm in
                
                let countryRealm = CountryVORealm()
                countryRealm.name = country.name
                countryRealm.location = country.location
                countryRealm.conDescription = country.conDescription
                countryRealm.averageRating = country.averageRating
                countryRealm.countryScoresAndReviews = country.countryScoresAndReviews
                countryRealm.photos = country.photos
                
                return countryRealm
            }
            
            print(countryList.count)
            RealmHelper.shared.saveCountries(tours: countryList, success: { (countryRealm) in
                //success(newsList)
                success(RealmHelper.shared.retrieveCountries())
                
            }) { (message) in
                failure(message)
                success(RealmHelper.shared.retrieveCountries())
            }
            
        }) { (message) in
            print("Network error -> \(message)")
            //success()
            success(RealmHelper.shared.retrieveCountries())
        }
    }
    
    func getAllCountriesN(success: @escaping ([CountryVORealm]) -> Void, failure : @escaping (String) -> Void) {
        
        ApiClient.shared.getAllCountries(success: { (countries) in
            
            let countryList = countries.map { (country) -> CountryVORealm in
                
                let countryRealm = CountryVORealm()
                countryRealm.name = country.name
                countryRealm.location = country.location
                countryRealm.conDescription = country.conDescription
                countryRealm.averageRating = country.averageRating
                countryRealm.countryScoresAndReviews = country.countryScoresAndReviews
                countryRealm.photos = country.photos
                
                return countryRealm
            }
            
            print(countryList.count)
            RealmHelper.shared.saveCountries(tours: countryList, success: { (countryRealm) in
                success(countryList)
                //success(RealmHelper.shared.retrieveCountriesN())
                
            }) { (message) in
                failure(message)
                success(RealmHelper.shared.retrieveCountriesN())
            }
            
        }) { (message) in
            print("Network error -> \(message)")
            //success()
            success(RealmHelper.shared.retrieveCountriesN())
        }
    }
    
    func getCountriesAndTours(){
        Observable.zip(
        ApiClient.shared.getAllToursObservable(), ApiClient.shared.getAllCountriesObservable()
        ){ tourList, countryList in
            return (countryList, tourList)
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
        .subscribe(onNext:{ countryAndTourTuple in
            // Insert into database
            _ = RealmHelper.shared.saveCountriesCompletable(countries: countryAndTourTuple.0)
                .subscribe()
            _ = RealmHelper.shared.saveToursCompletable(tours: countryAndTourTuple.1)
                .subscribe()
            
            })
        .disposed(by: disposebag)
    }
    
    func getToursObservable() -> Observable<[TourVORealm]>{
//        return ApiClient.shared.getAllToursObservable()
//            .flatMap{
//                RealmHelper.shared.saveToursCompletable(tours: $0)
//
//        }
//            .flatMap{ _ in
//                RealmHelper.shared.retrieveTours() }
//            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
        
        return RealmHelper.shared.retrieveTours()
    }
    
    func getCountriesObservable() -> Observable<[CountryVORealm]>{
//        return ApiClient.shared.getAllCountriesObservable()
//            .flatMap{ RealmHelper.shared.saveCountriesCompletable(countries: $0) }
//            .flatMap{ _ in
//                RealmHelper.shared.retrieveCountries() }
//            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
        return RealmHelper.shared.retrieveCountries()
    }
}
