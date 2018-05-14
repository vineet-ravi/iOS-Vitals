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
//  SpaceXNetworkManager.swift
//  iOS Essentials
//
//  Created by Vineet Ravi on 15/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import Foundation
import SwiftyJSON
import CocoaLumberjack

class SpaceXNetworkManager {
    
    static let shared = SpaceXNetworkManager()
    
    private init () {
        
    }
    
    // MARK: - Operation Queue
    fileprivate lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    func cancelAll() {
        downloadQueue.cancelAllOperations()
    }
    
    fileprivate func cancelOperation(identifier: String) {
        for operation in downloadQueue.operations {
            if operation.name == identifier {
                operation.cancel()
            }
        }
    }
    
    func getAllRocketInfo(completion: @escaping (_ isSuccess: Bool, _ statusCode: Int?, _ rockets: [RocketModel]?) -> Void) {
        let requestModel = NetworkRequestModel(url: SpaceXConstants.API.getAllRocketsInfo, httpMethod: .GET, body: nil, headers: nil)
        let networkOperation = NetworkOperation(model: requestModel) { (data, response, error, statusCode, isSuccess) in
            if isSuccess {
                if let jsonArray = JSON(data!).array {
                    var tempRocket = [RocketModel]()
                    for rocket in jsonArray {
                        let t = RocketModel(json: rocket)
                        tempRocket.append(t)
                    }
                    completion(true, statusCode, tempRocket)
                }
            } else {
                completion(false, statusCode, nil)
            }
        }
        downloadQueue.addOperations([networkOperation], waitUntilFinished: false)
        DDLogInfo("***** Operation counts - \(downloadQueue.operationCount)")
    }
    
    func cancelGetAllRocketInfo() {
        SpaceXNetworkManager.shared.cancelOperation(identifier: SpaceXConstants.API.getAllRocketsInfo)
    }
    
    
    func getCompanyInfo(completion: @escaping (_ isSuccess:Bool, _ statusCode:Int?, _ companyInfo: CompanyInfoModel?) -> Void) {
        let requestModel = NetworkRequestModel(url: SpaceXConstants.API.getCompanyInfo, httpMethod: .GET, body: nil, headers: nil)
        let networkOperation = NetworkOperation(model: requestModel) { (data, response, error, statusCode, isSuccess) in
            if isSuccess {
                if let _ = JSON(data!).dictionary {
                    let info = CompanyInfoModel(json: JSON(data!))
                    completion(true, statusCode, info)
                }
            } else {
                completion(false, statusCode, nil)
            }
        }
        downloadQueue.addOperations([networkOperation], waitUntilFinished: false)
        DDLogInfo("***** Operation counts - \(downloadQueue.operationCount)")
    }
    
    func cancelGetCompanyInfo() {
        SpaceXNetworkManager.shared.cancelOperation(identifier: SpaceXConstants.API.getCompanyInfo)
    }
    
    func getAllLaunches (completion: @escaping (_ isSuccess:Bool, _ statusCode:Int?, _ launchInfo: [LaunchInfoModel]?) -> Void) {
        let requestModel = NetworkRequestModel(url: SpaceXConstants.API.getAllLaunches, httpMethod: .GET, body: nil, headers: nil)
        let networkOperation = NetworkOperation(model: requestModel) { (data, response, error, statusCode, isSuccess) in
            if isSuccess {
                if let jsonArray = JSON(data!).array {
                    var tempLaunch = [LaunchInfoModel]()
                    for launch in jsonArray {
                        let t = LaunchInfoModel(json: launch)
                        tempLaunch.append(t)
                    }
                    completion(true, statusCode, tempLaunch)
                }
            } else {
                completion(false, statusCode, nil)
            }
        }
        downloadQueue.addOperations([networkOperation], waitUntilFinished: false)
        DDLogInfo("***** Operation counts - \(downloadQueue.operationCount) --- Adding -- \(SpaceXConstants.API.getAllLaunches)")
    }
    
    func cancelGetLatestSpaceXLaunches() {
        SpaceXNetworkManager.shared.cancelOperation(identifier: SpaceXConstants.API.getAllLaunches)
    }
}
