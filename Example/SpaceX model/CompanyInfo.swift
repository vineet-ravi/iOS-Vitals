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
//  CompanyInfo.swift
//  iOS Essentials
//
//  Created by Vineet Ravi on 23/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import Foundation
import SwiftyJSON

struct CompanyInfoModel {
    public private(set) var name: String
    public private(set) var founder: String
    public private(set) var founded: String
    public private(set) var employees: String
    public private(set) var vehicles: String
    public private(set) var launch_sites: String
    public private(set) var test_sites: String
    public private(set) var ceo: String
    public private(set) var cto: String
    public private(set) var coo: String
    public private(set) var cto_propulsion: String
    public private(set) var valuation: String
    public private(set) var headquarter: HeadquarterModel
    public private(set) var summary: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.founder = json["founder"].stringValue
        self.founded = json["founded"].stringValue
        self.employees = json["employees"].stringValue
        self.vehicles = json["vehicles"].stringValue
        self.launch_sites = json["launch_sites"].stringValue
        self.test_sites = json["test_sites"].stringValue
        self.ceo = json["ceo"].stringValue
        self.cto = json["cto"].stringValue
        self.coo = json["coo"].stringValue
        self.cto_propulsion = json["cto_propulsion"].stringValue
        self.valuation = json["valuation"].stringValue
        self.headquarter = HeadquarterModel(json: json["headquarter"])
        self.summary = json["summary"].stringValue
    }
}

struct HeadquarterModel {
    public private(set) var address: String
    public private(set) var city: String
    public private(set) var state: String
    
    init(json: JSON) {
        self.address = json["address"].stringValue
        self.city = json["city"].stringValue
        self.state = json["state"].stringValue
    }
}

extension CompanyInfoModel: Comparable {
    static func < (lhs: CompanyInfoModel, rhs: CompanyInfoModel) -> Bool {
        return Int(lhs.founded)! < Int(rhs.founded)!
    }
}

extension CompanyInfoModel: Equatable {
    static func == (lhs: CompanyInfoModel, rhs: CompanyInfoModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.founder == rhs.founder &&
            lhs.founded == rhs.founded &&
            lhs.employees == rhs.employees &&
            lhs.vehicles == rhs.vehicles &&
            lhs.launch_sites == rhs.launch_sites &&
            lhs.test_sites == rhs.test_sites &&
            lhs.ceo == rhs.ceo &&
            lhs.cto == rhs.cto &&
            lhs.cto_propulsion == rhs.cto_propulsion &&
            lhs.valuation == rhs.valuation &&
            lhs.headquarter == rhs.headquarter &&
            lhs.summary == rhs.summary
    }
}

extension CompanyInfoModel: Hashable {
    var hashValue: Int {
        return founder.djb2hash ^ founded.hashValue ^ employees.hashValue
    }
}

extension HeadquarterModel: Equatable {
    static func == (lhs: HeadquarterModel, rhs: HeadquarterModel) -> Bool {
        return lhs.address == rhs.address &&
        lhs.city == rhs.city &&
        lhs.state == rhs.state
    }
}

extension String {
    var djb2hash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
    
    var sdbmhash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(0) {
            Int($1) &+ ($0 << 6) &+ ($0 << 16) - $0
        }
    }
}




