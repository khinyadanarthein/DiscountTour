//
//  Api.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

protocol Api {
    func getAllTours(
        success: @escaping([TourVORealm]) -> Void,
        fail: @escaping(String) ->Void)
    
    func getAllCountries(
    success: @escaping([CountryVORealm]) -> Void,
    fail: @escaping(String) ->Void)
    
    func getAllToursObservable() -> Observable<[TourVORealm]>
}
