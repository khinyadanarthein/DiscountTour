//
//  RealmHelper.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

public class RealmHelper {
    
    public static let shared : RealmHelper = RealmHelper()
    
    private let realm = try! Realm()
    
    private init() {}
    
    func saveTours(tours : [TourVORealm],success: (Observable<[TourVORealm]>) -> Void, failure: @escaping (String) -> Void) {
        
        do {
            try realm.write{
                realm.add(tours, update: .modified)
                success(retrieveTours())
            }
        } catch let error {
            print(error.localizedDescription)
            failure(error as! String)
        }
        
    }
    
    func saveCountriesCompletable(countries : [CountryVORealm]) -> Completable{
        Completable.create(subscribe: { completable in
            do {
                try self.realm.write{
                    self.realm.add(countries, update: .modified)
                    completable(.completed)
                }
            } catch let error {
                completable(.error(error))
            }
            return Disposables.create()
        })
    }
    
    func saveToursCompletable(tours : [TourVORealm]) -> Completable{
        Completable.create(subscribe: { completable in
            do {
                try self.realm.write{
                    self.realm.add(tours, update: .modified)
                    completable(.completed)
                }
            } catch let error {
                completable(.error(error))
            }
            return Disposables.create()
        })
    }
    
    func retrieveTours() -> Observable<[TourVORealm]> {
        return Observable.array(from: realm.objects(TourVORealm.self))
    }
    
    
    func retrieveToursN() -> [TourVORealm] {
        return Array(realm.objects(TourVORealm.self))
    }
    
    func saveCountries(tours : [CountryVORealm],success: (Observable<[CountryVORealm]>) -> Void, failure: @escaping (String) -> Void) {
        
        do {
            try realm.write{
                realm.add(tours, update: .modified)
                success(retrieveCountries())
            }
        } catch let error {
            print(error.localizedDescription)
            failure(error as! String)
        }
        
    }
    
    func retrieveCountries() -> Observable<[CountryVORealm]> {
        return Observable.array(from: realm.objects(CountryVORealm.self))
    }
    
    
    func retrieveCountriesN() -> [CountryVORealm] {
        return Array(realm.objects(CountryVORealm.self))
    }
    
}
