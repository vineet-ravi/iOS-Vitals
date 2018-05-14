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
//  NetworkManager.swifts
//  iOS Essentials
//
//  Created by Vineet Ravi on 15/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import CocoaLumberjack

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?, Int?, Bool) -> Void

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private  init() {
        //This prevents others from using the default '()' initializer for this class
    }
    
    private lazy var defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    fileprivate var allRunningNetworkCalls = [URLSessionDataTask]()
    
    func httpCall(model: NetworkRequestModel, completionHandler: @escaping NetworkCompletionHandler) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        var request = URLRequest(url: URL(string: model.url)!)
        request.allHTTPHeaderFields = model.headers
        
        switch model.httpMethod {
        case .POST:
            request.httpMethod = "POST"
            do {
                if let mModelBody = model.body {
                    request.httpBody = try JSONSerialization.data(withJSONObject: mModelBody, options: [])
                }
            } catch let error {
                DDLogInfo(error.localizedDescription)
            }
            break
            
        case .GET:
            request.httpMethod = "GET"
            break
        }
        
        let networkCall = defaultSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard error == nil else {
                completionHandler(nil, response, error, (response as? HTTPURLResponse)?.statusCode, false)
                DDLogInfo(" ----- >>>>> Error: - \(String(describing: error?.localizedDescription)) <<<<< ----- ")
                return
            }
            
            guard let mResponse = response else {
                completionHandler(nil, nil, nil, nil, false)
                DDLogInfo(" ----- >>>>> Error:Response nil <<<<< ----- ")
                return
            }
            
            guard let mData = data else {
                completionHandler(nil, response, error, nil, false)
                DDLogInfo(" ----- >>>>> Error: did not receive data <<<<< ----- ")
                return
            }
            
            if let mStatuscode = response as? HTTPURLResponse {
                switch mStatuscode.statusCode {
                case 200:
                    completionHandler(mData, mResponse, nil, mStatuscode.statusCode, true)
                    break
                    
                default:
                    completionHandler(mData, mResponse, nil, mStatuscode.statusCode, false)
                    break
                }
            } else {
                completionHandler(mData, mResponse, nil, nil, false)
            }
        }
        networkCall.resume()
        
        DispatchQueue.main.async {
            self.allRunningNetworkCalls.append(networkCall)
        }
    }
    
    func cancelAllHttpCalls() {
        for currentTask in allRunningNetworkCalls {
            currentTask.cancel()
        }
    }
    
    func cancelHttpCall(identifier: String ){
            for currentTask in allRunningNetworkCalls {
                if currentTask.currentRequest?.url?.absoluteString == identifier {
                    currentTask.cancel()
                    if let index = self.allRunningNetworkCalls.index(of: currentTask) {
                        self.allRunningNetworkCalls.remove(at: index)
                    }
                }
            }
    }
}

extension NetworkManager {
    func isNetworkReachable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
