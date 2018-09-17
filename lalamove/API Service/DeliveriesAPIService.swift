//
//  DeliveriesAPIService.swift
//  lalamove
//
//  Created by Muhammad Khan on 17/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import Foundation
import Alamofire

struct DeliveriesAPIService {
    
    private init () {}
    
    static let shared = DeliveriesAPIService()
    
    func getDeliveries(completion: @escaping ([Delivery]?, Error?) -> ()) {
        
        let url = AppConstants.shared.getDeliveriesURL()
        
        DispatchQueue.global(qos: .background).async {
            
            Alamofire.request(url).response { (response) in
                
                if let error = response.error {
                    
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                } else {
                    do {
                        let decoder = JSONDecoder()
                        
                        if let data = response.data {
                            
                            let deliveries = try decoder.decode([Delivery].self, from: data)
                            
                            DispatchQueue.main.async {
                                completion(deliveries, nil)
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                    }
                }
            }
        }
    }
}
