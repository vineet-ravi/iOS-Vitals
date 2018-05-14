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
//  SpaceXCoreData.swift
//  iOS-Vitals
//
//  Created by Vineet Ravi on 24/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import Foundation
import CoreData
import CocoaLumberjack

class SpaceXCoreData {
    
    static let shared = SpaceXCoreData()
    
    let backgroundContext: NSManagedObjectContext?
    
    private let coreDataManager = CoreDataStack(modelName: "SpaceX")
    
    private init() {
        backgroundContext = coreDataManager.persistentContainer.newBackgroundContext()
        print("\n**\n**\n SQLite file path ** \n\(coreDataManager.sqlitePath) \n\n\n")
    }
    
    func saveAllLaunches(_ launches: [LaunchInfoModel]?, context: NSManagedObjectContext) {
        if let launches = launches, launches.count != 0 {
            for launchInfo in launches {
                let launch = LaunchInfo(entity: LaunchInfo.entity(), insertInto: context) // LaunchInfo Entity
                launch.flightNumber = launchInfo.flightNumber
                launch.launchYear = launchInfo.launchYear
                launch.launchDateUnix = launchInfo.launchDateUnix
                launch.launchDateUTC = launchInfo.launchDateUtc
                launch.launchDateLocal = launchInfo.launchDateLocal
                launch.launchSuccess = launchInfo.launchSuccess
                launch.details = launchInfo.details
                
                let mRocket = RocketInfo(entity: RocketInfo.entity(), insertInto: context) // RocketInfo Entity
                mRocket.rocketID = launchInfo.rocket.rocket_id
                mRocket.rocketName = launchInfo.rocket.rocket_name
                mRocket.rocketType = launchInfo.rocket.rocket_type
                let mFirstStage = RocketFirstStage(entity: RocketFirstStage.entity(), insertInto: context) // RocketFirstStage Entity
                for core in launchInfo.rocket.firstStage.cores {
                    let mCore = RocketCore(entity: RocketCore.entity(), insertInto: context) // RocketCore Entity
                    mCore.coreSerial = core.core_serial
                    mCore.flight = core.flight
                    mCore.block = core.block
                    mCore.reused = core.reused
                    mCore.landSuccess = core.land_success
                    mCore.landingType = core.landing_type
                    mCore.landingVehicle = core.landing_vehicle
                    mFirstStage.addToCores(mCore)
                }
                mRocket.firstStage = mFirstStage
                
                let mSecondStage = RocketSecondStage(entity: RocketSecondStage.entity(), insertInto: context)  // RocketSecondStage Entity
                for payload in launchInfo.rocket.secondStage.payloads {
                    let mPayLoad = RocketPayload(entity: RocketPayload.entity(), insertInto: context)  // RocketPayload Entity
                    mPayLoad.payloadID = payload.payload_id
                    mPayLoad.reused = payload.reused
                    mPayLoad.payloadType = payload.payload_type
                    mPayLoad.payloadMassKG = payload.payload_mass_kg
                    mPayLoad.payloadMassLBS = payload.payload_mass_lbs
                    for customer in payload.customers {
                        let mCustomer = Customer(entity: Customer.entity(), insertInto: context) // Customer Entity
                        mCustomer.name = customer
                        mPayLoad.addToCustomers(mCustomer)
                    }
                    mSecondStage.addToPayloads(mPayLoad)
                }
                mRocket.secondStage = mSecondStage
                launch.rocket = mRocket
                
                let mTelemetry = Telemetry(entity: Telemetry.entity(), insertInto: context) // Telemetry Entity
                mTelemetry.flightClub = launchInfo.telemetry.flight_club
                launch.telemetry = mTelemetry
                
                let mReuse = Reuse(entity: Reuse.entity(), insertInto: context) // Reuse Entity
                mReuse.core = launchInfo.reuse.core
                mReuse.sideCore1 = launchInfo.reuse.side_core1
                mReuse.sideCore2 = launchInfo.reuse.side_core2
                mReuse.fairings = launchInfo.reuse.fairings
                mReuse.capsule = launchInfo.reuse.capsule
                launch.reuse = mReuse
                
                let mLaunchSite = LaunchSite(entity: LaunchSite.entity(), insertInto: context)  // LaunchSite Entity
                mLaunchSite.siteID = launchInfo.launchSite.site_id
                mLaunchSite.siteName = launchInfo.launchSite.site_name
                mLaunchSite.siteNameLong = launchInfo.launchSite.site_name_long
                launch.launchSite = mLaunchSite
                
                let mLink = Links(entity: Links.entity(), insertInto: context)  // Links Entity
                mLink.articleLink = URL(string: launchInfo.links.article_link)
                mLink.missionPatch = URL(string: launchInfo.links.mission_patch)
                mLink.missionPatchSmall = URL(string: launchInfo.links.mission_patch_small)
                mLink.presskit = URL(string: launchInfo.links.presskit)
                mLink.redditCampaign = URL(string: launchInfo.links.reddit_campaign)
                mLink.redditMedia = URL(string: launchInfo.links.reddit_media)
                mLink.redditLaunch = URL(string: launchInfo.links.reddit_launch)
                mLink.redditRecovery = URL(string: launchInfo.links.reddit_recovery)
                mLink.videoLink = URL(string: launchInfo.links.video_link)
                launch.link = mLink
                
                coreDataManager.saveChanges(context) { (isSuccess) in
                    if isSuccess {
                    } else {
                        DDLogInfo("Failed to saved")
                    }
                }
            }
        }
    }
    
    func deleteAllLaunches(context: NSManagedObjectContext) {
        do {
            let launchs = try context.fetch(LaunchInfo.fetchRequest())
            for launch in launchs {
                if let mlaunch = launch as? NSManagedObject {
                    context.delete(mlaunch)
                }
            }
        } catch let error as NSError? {
            DDLogInfo("Unable to delete : \(String(describing: error)) \(String(describing: error?.userInfo))")
        }
    }
    
    func saveCompanyInformation(_ information: CompanyInfoModel?, context: NSManagedObjectContext) {
        if let mCompany = information {
            let company = Company(entity: Company.entity(), insertInto: context)
            company.name = mCompany.name
            company.founder = mCompany.founder
            company.founded = mCompany.founded
            company.employees = mCompany.employees
            company.vehicles = mCompany.vehicles
            company.launchSites = mCompany.launch_sites
            company.testSites = mCompany.test_sites
            company.ceo = mCompany.ceo
            company.cto = mCompany.cto
            company.coo = mCompany.coo
            company.ctoPropulsion = mCompany.cto_propulsion
            company.valuation = mCompany.valuation
            
            let headquarter = Headquarter(entity: Headquarter.entity(), insertInto: context)
            headquarter.address = mCompany.headquarter.address
            headquarter.city = mCompany.headquarter.city
            headquarter.state = mCompany.headquarter.state
            company.headquarter = headquarter
            
            coreDataManager.saveChanges(context) { (isSuccess) in
                if isSuccess {
                    
                } else {
                    
                }
            }
        }
    }
}
