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
//  Rocket.swift
//  iOS Essentials
//
//  Created by Vineet Ravi on 23/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import Foundation
import SwiftyJSON

struct RocketModel {
    public private(set) var id: String
    public private(set) var name: String
    public private(set) var type: String
    public private(set) var active: String
    public private(set) var stages: String
    public private(set) var boosters: String
    public private(set) var cost_per_launch: String
    public private(set) var success_rate_pct: String
    public private(set) var first_flight: String
    public private(set) var country: String
    public private(set) var company: String
    public private(set) var height: HeightModel
    public private(set) var diameter: DiameterModel
    public private(set) var mass: MassModel
    public private(set) var payloadInfo = [PayloadInfoModel]()
    public private(set) var firstStage: RocketFirstStageModel
    public private(set) var secondStage: RocketSecondStageModel
    public private(set) var engine: EnginesModel
    public private(set) var landingLegs: LandingLegsModel
    public private(set) var description: String
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.type = json["type"].stringValue
        self.active = json["active"].stringValue
        self.stages = json["stages"].stringValue
        self.boosters = json["boosters"].stringValue
        self.cost_per_launch = json["cost_per_launch"].stringValue
        self.success_rate_pct = json["success_rate_pct"].stringValue
        self.first_flight = json["first_flight"].stringValue
        self.country = json["country"].stringValue
        self.company = json["company"].stringValue
        self.height = HeightModel(json: json["height"])
        self.diameter = DiameterModel(json: json["diameter"])
        self.mass = MassModel(json: json["mass"])
        for payload in json["payload_weights"].arrayValue {
            let model = PayloadInfoModel(json: payload)
            self.payloadInfo.append(model)
        }
        self.firstStage = RocketFirstStageModel(json: json["first_stage"])
        self.secondStage = RocketSecondStageModel(json: json["second_stage"])
        self.engine = EnginesModel(json: json["engines"])
        self.landingLegs = LandingLegsModel(json: json["landing_legs"])
        self.description = json["description"].stringValue
    }
}

struct LandingLegsModel {
    public private(set) var number: String
    public private(set) var material: String
    init(json: JSON) {
        self.number = json["number"].stringValue
        self.material = json["material"].stringValue
    }
}

struct EnginesModel {
    public private(set) var number: String
    public private(set) var type: String
    public private(set) var version: String
    public private(set) var layout: String
    public private(set) var engine_loss_max: String
    public private(set) var propellant_1: String
    public private(set) var propellant_2: String
    public private(set) var thrust_sea_level: ThrustModel
    public private(set) var thrust_vacuum: ThrustModel
    public private(set) var thrust_to_weight: String
    init(json: JSON) {
        self.number = json["number"].stringValue
        self.type = json["type"].stringValue
        self.version = json["version"].stringValue
        self.layout = json["layout"].stringValue
        self.engine_loss_max = json["engine_loss_max"].stringValue
        self.propellant_1 = json["propellant_1"].stringValue
        self.propellant_2 = json["propellant_2"].stringValue
        self.thrust_sea_level = ThrustModel(json: json["thrust_sea_level"])
        self.thrust_vacuum = ThrustModel(json: json["thrust_vacuum"])
        self.thrust_to_weight = json["thrust_to_weight"].stringValue
    }
}

struct HeightModel {
    public private(set) var meters: String
    public private(set) var feet: String
    init(json: JSON) {
        self.meters = json["meters"].stringValue
        self.feet = json["feet"].stringValue
    }
}
    
struct DiameterModel {
    public private(set) var meters: String
    public private(set) var feet: String
    init(json: JSON) {
        self.meters = json["meters"].stringValue
        self.feet = json["feet"].stringValue
    }
}

struct MassModel {
    public private(set) var kg: String
    public private(set) var lb: String
    init(json: JSON) {
        self.kg = json["kg"].stringValue
        self.lb = json["lb"].stringValue
    }
}

struct PayloadInfoModel {
    public private(set) var id: String
    public private(set) var name: String
    public private(set) var kg: String
    public private(set) var lb: String
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.kg = json["kg"].stringValue
        self.lb = json["lb"].stringValue
    }
}

struct RocketFirstStageModel {
    public private(set) var reusable: Bool
    public private(set) var engines: String
    public private(set) var fuel_amount_tons: String
    public private(set) var burn_time_sec: String
    public private(set) var seaLevelThrust: ThrustModel
    public private(set) var vaccumThrust: ThrustModel
    init(json: JSON) {
        self.reusable = json["reusable"].boolValue
        self.engines = json["engines"].stringValue
        self.fuel_amount_tons = json["fuel_amount_tons"].stringValue
        self.burn_time_sec = json["burn_time_sec"].stringValue
        self.seaLevelThrust = ThrustModel(json: json["thrust_sea_level"])
        self.vaccumThrust = ThrustModel(json: json["thrust_vacuum"])
    }
}

struct RocketSecondStageModel {
    public private(set) var engines: String
    public private(set) var fuel_amount_tons: String
    public private(set) var burn_time_sec: String
    public private(set) var thrust: ThrustModel
    public private(set) var payloads: SecondStagePayloadModel
    init(json: JSON) {
        self.engines = json["engines"].stringValue
        self.fuel_amount_tons = json["fuel_amount_tons"].stringValue
        self.burn_time_sec = json["burn_time_sec"].stringValue
        self.thrust = ThrustModel(json: json["thrust"])
        self.payloads = SecondStagePayloadModel(json: json["payloads"])
    }
}

struct SecondStagePayloadModel {
    public private(set) var option_1: String
    public private(set) var compositeFairing: CompositeFairingModel
    init(json: JSON) {
        self.option_1 = json["option_1"].stringValue
        self.compositeFairing = CompositeFairingModel(json: json["composite_fairing"])
    }
}

struct CompositeFairingModel {
    public private(set) var height: HeightModel
    public private(set) var diameter: DiameterModel
    init(json: JSON) {
        self.height = HeightModel(json: json["height"])
        self.diameter = DiameterModel(json: json["height"])
    }
}

struct ThrustModel {
    public private(set) var kn: String
    public private(set) var lbf: String
    init(json: JSON) {
        self.kn = json["kN"].stringValue
        self.lbf = json["lbf"].stringValue
    }
}


