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
//  NetworkOperation.swift
//  iOS Essentials
//
//  Created by Vineet Ravi on 15/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import Foundation
import CocoaLumberjack

class NetworkOperation: AsyncOperation {
    
    fileprivate let model: NetworkRequestModel
    fileprivate let identifier: String
    fileprivate let completion: NetworkCompletionHandler
    
    init(model: NetworkRequestModel, completion: @escaping NetworkCompletionHandler) {
        self.model = model
        self.identifier = model.url
        self.completion = completion
    }
    
    override func main() {
        if self.isCancelled { return }
        self.qualityOfService = .userInitiated
        self.queuePriority = .high
        self.name = identifier
        NetworkManager.shared.httpCall(model: model) { (data, response, error, statusCode, isSuccess) in
            if self.isCancelled { return }
            self.completion(data, response, error, statusCode, isSuccess)
            self.state = .Finished
        }
    }
    
    override func cancel() {
        
        DispatchQueue.main.async {
            NetworkManager.shared.cancelHttpCall(identifier: self.identifier)
            self.state = .Finished
            DDLogInfo("Cancelling operation name: - \(self.identifier)")
        }
    }
}
