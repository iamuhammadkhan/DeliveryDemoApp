//
//  AppConstants.swift
//  lalamove
//
//  Created by Muhammad Khan on 17/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import Foundation

struct AppConstants {
    
    private init () {}
    
    static let shared = AppConstants()
    
    private let scheme = "https://"
    
    private let host = "lalamove.com"
    
    private let path = "mock-api-mobile.dev."
    
    private let deliveries = "/deliveries"
    
    func getBaseURL() -> String {
        return "\(scheme)\(path)\(host)"
    }
    
    func getDeliveriesURL() -> String {
        let url = getBaseURL()
        return "\(url)\(deliveries)"
    }
}
