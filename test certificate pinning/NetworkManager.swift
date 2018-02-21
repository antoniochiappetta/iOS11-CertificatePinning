//
//  NetworkManager.swift
//  test certificate pinning
//
//  Created by Antonio Chiappetta on 21/02/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    let afManager: SessionManager!
    
    private init() {
        afManager = SessionManager(
            configuration: URLSessionConfiguration.default,
            delegate: SessionDelegate(),
            serverTrustPolicyManager: ServerTrustPolicyManager(policies:
                [
                    "www.apple.com": ServerTrustPolicy.pinCertificates(
                        certificates: ServerTrustPolicy.certificates(),
                        validateCertificateChain: true,
                        validateHost: true
                    )
                ]
            )
        )
    }
    
    func connectToApple() {
        afManager.request("www.apple.com", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (dataResponse) in
            if let error = dataResponse.error {
                print(error)
            }
            if let data = dataResponse.data {
                print(data)
            }
        }
    }
    
}
