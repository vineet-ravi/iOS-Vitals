// MIT License

// Copyright (c) 2018 Vineet Ravi

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//
//  ViewController.swift
//  iOS Essentials
//
//  Created by Vineet Ravi on 14/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import UIKit
import CocoaLumberjack

class SpaceXViewController: UIViewController {
    
    private var backgroundContext = SpaceXCoreData.shared.backgroundContext!
    
    private var launchs = [LaunchInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
    }
    
    
    
    @IBAction func deleteAll(_ sender: UIButton) {
        SpaceXCoreData.shared.deleteAllLaunches(context: backgroundContext)
    }
    
    @IBAction func fetchButtonClicked(_ sender: UIButton) {
        do {
            DDLogInfo("***** Will Set *******")
            try self.launchs = self.backgroundContext.fetch(LaunchInfo.fetchRequest())
            //                for launch in self.launchs {
            //                    DDLogInfo("\(String(describing: launch.flightNumber))")
            //                    DDLogInfo("\(String(describing: launch.rocket?.rocketID))")
            //
            //                    for core in (launch.rocket?.firstStage?.cores)! {
            //                        DDLogInfo("Core : - \(String(describing: (core as? RocketCore)?.coreSerial))")
            //                    }
            //
            //                    for payload in (launch.rocket?.secondStage?.payloads)! {
            //                        DDLogInfo("payload : - \(String(describing: (payload as? RocketPayload)?.payloadID))")
            //                    }
            //
            //                    DDLogInfo("\(String(describing: launch.telemetry?.flightClub))")
            //                    DDLogInfo("\(String(describing: launch.reuse?.capsule))")
            //                    DDLogInfo("\(String(describing: launch.launchSite?.siteID))")
            //                    DDLogInfo("\(String(describing: launch.launchSuccess))")
            //                    DDLogInfo("\(String(describing: launch.link?.articleLink))")
            //                    DDLogInfo("\n\n")
            //                }
            DDLogInfo("***** DID Set *******")
            DDLogInfo("Total - \(self.launchs.count)")
            DDLogInfo("\n\n")
        } catch let error as NSError? {
            DDLogInfo("Unable to fetch : \(String(describing: error)) \(String(describing: error?.userInfo))")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func allLaunchesButtonClicked(_ sender: UIButton) {
        SpaceXNetworkManager.shared.getAllLaunches { (isSuccess, statusCode, launchInfo) in
            if isSuccess {
                DDLogInfo("**** Success")
                DispatchQueue.main.async {
                    SpaceXCoreData.shared.saveAllLaunches(launchInfo, context: self.backgroundContext)
                }
            } else {
                DDLogInfo("**** Cancelled")
            }
        }
    }
    
    @IBAction func companyInfoButtonClicked(_ sender: UIButton) {
        SpaceXNetworkManager.shared.getCompanyInfo { (isSuccess, statusCode, companyInfo) in
            if isSuccess {
                DDLogInfo("**** Success")
                DDLogInfo("\(String(describing: companyInfo))")
                SpaceXCoreData.shared.saveCompanyInformation(companyInfo, context: self.backgroundContext)
            } else {
                DDLogInfo("**** Cancelled by user")
            }
        }
    }
    
    @IBAction func allRocketsInfoClicked(_ sender: UIButton) {
        SpaceXNetworkManager.shared.getAllRocketInfo { (isSuccess, statusCode, rockets) in
            if isSuccess {
                DDLogInfo("**** Success")
                DDLogInfo("\(String(describing: rockets))")
            } else {
                DDLogInfo("**** Cancelled 3")
            }
        }
    }
    
    @IBAction func cancel3(_ sender: UIButton) {
        SpaceXNetworkManager.shared.cancelGetAllRocketInfo()
    }
    
    
    @IBAction func cancelTwo(_ sender: UIButton) {
        SpaceXNetworkManager.shared.cancelGetCompanyInfo()
    }
    
    
    @IBAction func cancelOne(_ sender: UIButton) {
        SpaceXNetworkManager.shared.cancelGetLatestSpaceXLaunches()
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        SpaceXNetworkManager.shared.cancelAll()
    }
    
}
