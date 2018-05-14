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
//  LogFormat.swift
//  iOS Essentials
//
//  Created by Vineet Ravi on 16/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import Foundation
import CocoaLumberjack

class LogFormatter: NSObject, DDLogFormatter {
    let dateFormatter: DateFormatter
    
    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.formatterBehavior = .behavior10_4
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        
        super.init()
    }
    func format(message logMessage: DDLogMessage) -> String? {
        let dateAndTime = dateFormatter.string(from: logMessage.timestamp)
        return "\(dateAndTime) [\(logMessage.fileName):\(logMessage.line)]: \(logMessage.message)"
    }
}
