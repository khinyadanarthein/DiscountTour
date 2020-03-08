//
//  ApiClient.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class ApiClient: BaseApiClient {
    
    static let shared:ApiClient = ApiClient()
    
    private override init() {
        
    }
}

extension ApiClient : Api{
    
    func getAllToursObservable() -> Observable<[TourVORealm]> {
        let params : Parameters = [:]
        
        let headers : HTTPHeaders = [:]
        
        return Observable.create{ observer in
            
            self.requestApi(
                url: API_TOURS,
                header: headers,
                method: .get,
                params: params,
                success: { (response) in
                    
                    let data = try!JSONDecoder().decode(TourResponse.self, from: response)
                    observer.onNext(data.tours)
                    
            }) { (error) in
                observer.onError(NSError(domain: error, code: 404, userInfo: nil))
            }
            
            return Disposables.create()
        }
    }
    
    func getAllCountriesObservable() -> Observable<[CountryVORealm]>{
        let params : Parameters = [:]
        
        let headers : HTTPHeaders = [:]
        
        return Observable.create{ observer in
            self.requestApi(
                url: API_COUNTRIES,
                header: headers,
                method: .get,
                params: params,
                success: { (response) in
                    
                    let data = try!JSONDecoder().decode(CountryResponse.self, from: response)
                    
                    observer.onNext(data.countries)
                    
            }) { (error) in
                                observer.onError(NSError(domain: error, code: 404, userInfo: nil))

            }
            return Disposables.create()
        }
        
    }
    
    
    func getAllTours(success: @escaping ([TourVORealm]) -> Void, fail: @escaping (String) -> Void) {
     
        let params : Parameters = [:]
        
        let headers : HTTPHeaders = [:]
        self.requestApi(
            url: API_TOURS,
            header: headers,
            method: .get,
            params: params,
            success: { (response) in
                
                let data = try!JSONDecoder().decode(TourResponse.self, from: response)
                
                print(data)
                success(data.tours)
                
        }) { (error) in
            print(error)
        }
    }
    
    func getAllCountries(success: @escaping ([CountryVORealm]) -> Void, fail: @escaping (String) -> Void) {
     
        let params : Parameters = [:]
        
        let headers : HTTPHeaders = [:]
        
        self.requestApi(
            url: API_COUNTRIES,
            header: headers,
            method: .get,
            params: params,
            success: { (response) in
                
                let data = try!JSONDecoder().decode(CountryResponse.self, from: response)
                
                print(data)
                success(data.countries)
                
        }) { (error) in
            print(error)
        }
    }
    
    
}
