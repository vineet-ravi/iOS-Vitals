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
//  LaunchInfo.swift
//  iOS Essentials
//
//  Created by Vineet Ravi on 18/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import Foundation
import SwiftyJSON

struct LaunchInfoModel {
    public private(set) var flightNumber: String
    public private(set) var launchYear: String
    public private(set) var launchDateUnix: String
    public private(set) var launchDateUtc: String
    public private(set) var launchDateLocal: String
    public private(set) var rocket: RocketInfoModel
    public private(set) var telemetry: TelemetryModel
    public private(set) var reuse: ReuseModel
    public private(set) var launchSite: LaunchSiteModel
    public private(set) var links: LinksModel
    public private(set) var launchSuccess: Bool
    public private(set) var details: String
    init(json: JSON) {
        self.flightNumber = json["flight_number"].stringValue
        self.launchYear = json["launch_year"].stringValue
        self.launchDateUnix = json["launch_date_unix"].stringValue
        self.launchDateUtc = json["launch_date_utc"].stringValue
        self.launchDateLocal = json["launch_date_local"].stringValue
        self.rocket = RocketInfoModel(json: json["rocket"])
        self.telemetry = TelemetryModel(json: json["telemetry"])
        self.reuse = ReuseModel(json: json["reuse"])
        self.launchSite = LaunchSiteModel(json: json["launch_site"])
        self.links = LinksModel(json: json["links"])
        self.launchSuccess = json["launch_success"].boolValue
        self.details = json["details"].stringValue
    }
}

struct RocketInfoModel {
    public private(set) var rocket_id: String
    public private(set) var rocket_name: String
    public private(set) var rocket_type: String
    public private(set) var firstStage: FirstStageModel
    public private(set) var secondStage: SecondStageModel
    init(json: JSON) {
        self.rocket_id = json["rocket_id"].stringValue
        self.rocket_name = json["rocket_name"].stringValue
        self.rocket_type = json["rocket_type"].stringValue
        self.firstStage = FirstStageModel(json: json["first_stage"])
        self.secondStage = SecondStageModel(json: json["second_stage"])
    }
}

struct FirstStageModel {
    public private(set) var cores = [CoreModel]()
    init(json: JSON) {
        for core in json["cores"].arrayValue {
            let model = CoreModel(json: core)
            cores.append(model)
        }
    }
}

struct SecondStageModel {
    public private(set) var payloads = [PayloadModel]()
    init(json: JSON) {
        for payload in json["payloads"].arrayValue {
            let model = PayloadModel(json: payload)
            payloads.append(model)
        }
    }
}

struct CoreModel {
    public private(set) var core_serial: String
    public private(set) var flight: String
    public private(set) var block: String
    public private(set) var reused: Bool
    public private(set) var land_success: Bool
    public private(set) var landing_type: String
    public private(set) var landing_vehicle: String
    init(json: JSON) {
        self.core_serial = json["core_serial"].stringValue
        self.flight = json["flight"].stringValue
        self.block = json["block"].stringValue
        self.reused = json["reused"].boolValue
        self.land_success = json["land_success"].boolValue
        self.landing_type = json["landing_type"].stringValue
        self.landing_vehicle = json["landing_vehicle"].stringValue
    }
}

struct PayloadModel {
    public private(set) var payload_id: String
    public private(set) var reused: Bool
    public private(set) var customers = [String]()
    public private(set) var payload_type: String
    public private(set) var payload_mass_kg: String
    public private(set) var payload_mass_lbs: String
    public private(set) var orbit: String

    init(json: JSON) {
        self.payload_id = json["payload_id"].stringValue
        self.reused = json["reused"].boolValue
        for name in json["customers"].arrayValue {
            self.customers.append(name.stringValue)
        }
        self.payload_type = json["payload_type"].stringValue
        self.payload_mass_kg = json["payload_mass_kg"].stringValue
        self.payload_mass_lbs = json["payload_mass_lbs"].stringValue
        self.orbit = json["orbit"].stringValue
    }
}

struct TelemetryModel {
    public private(set) var flight_club: String
    init(json: JSON) {
        self.flight_club = json["flight_club"].stringValue
    }
}

struct ReuseModel {
    public private(set) var core: Bool
    public private(set) var side_core1: Bool
    public private(set) var side_core2: Bool
    public private(set) var fairings: Bool
    public private(set) var capsule: Bool
    init(json: JSON) {
        self.core = json["core"].boolValue
        self.side_core1 = json["side_core1"].boolValue
        self.side_core2 = json["side_core2"].boolValue
        self.fairings = json["fairings"].boolValue
        self.capsule = json["capsule"].boolValue
    }
}

struct LaunchSiteModel {
    public private(set) var site_id: String
    public private(set) var site_name: String
    public private(set) var site_name_long: String
    init(json: JSON) {
        self.site_id = json["site_id"].stringValue
        self.site_name = json["site_name"].stringValue
        self.site_name_long = json["site_name_long"].stringValue
    }
}

struct LinksModel {
    public private(set) var mission_patch: String
    public private(set) var mission_patch_small: String
    public private(set) var reddit_campaign: String
    public private(set) var reddit_launch: String
    public private(set) var reddit_recovery: String
    public private(set) var reddit_media: String
    public private(set) var presskit: String
    public private(set) var article_link: String
    public private(set) var video_link: String
    init(json: JSON) {
        self.mission_patch = json["mission_patch"].stringValue
        self.mission_patch_small = json["mission_patch_small"].stringValue
        self.reddit_campaign = json["reddit_campaign"].stringValue
        self.reddit_launch = json["reddit_launch"].stringValue
        self.reddit_recovery = json["reddit_recovery"].stringValue
        self.reddit_media = json["reddit_media"].stringValue
        self.presskit = json["presskit"].stringValue
        self.article_link = json["article_link"].stringValue
        self.video_link = json["video_link"].stringValue
    }
}
