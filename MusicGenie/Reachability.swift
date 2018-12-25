//
//  Reachability.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 25/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit
import Alamofire

class NetworkReachability: NSObject {
    open static var sharedManager: NetworkReachabilityManager = {
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.listener = { (status) in
            switch status {
            case .notReachable:
                print("The network is not reachable")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unsuccessful"), object: nil)
            case .unknown:
                print("It is unknown wether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successful"), object: nil)
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successful"), object: nil)
            }
        }
        reachabilityManager?.startListening()
        return reachabilityManager!
    }()
}
