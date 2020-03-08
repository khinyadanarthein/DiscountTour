//
//  BaseApiClient.swift
//  discounttour
//
//  Created by Khin Yadanar Thein on 29/02/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import Alamofire

class BaseApiClient {
    
    static let BASE_URL = "https://3d228c72-b22e-4b75-a1d7-06d695046062.mock.pstmn.io/"
    
    func requestApi(
        url:String,
        header:HTTPHeaders,
        method:HTTPMethod,
        params:Parameters,
        encoding:ParameterEncoding = URLEncoding.default,
        success: @escaping(Data) -> Void,
        fail: @escaping(String) ->Void) {
        
        (AF.request(BaseApiClient.BASE_URL + url, method: method, parameters: params, encoding: encoding,headers: header)).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                success(response.data!)
                
            case .failure(let error):
                
                debugPrint(error.localizedDescription)
                
                fail(error.localizedDescription)
            }
        }
        
    }
}
