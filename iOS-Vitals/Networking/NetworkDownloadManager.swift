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
//  NetworkDownloadManager.swift
//  iOS-Vitals
//
//  Created by Vineet Ravi on 26/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//

import UIKit
import Foundation

protocol NetworkDownloadManagerDelegate {
    func didUpdateDownloadInProgress(model: NetworkRequestModel, task: URLSessionDownloadTask, progress: Float)
    func didFinishDownloading(model: NetworkRequestModel, task: URLSessionDownloadTask, location: URL)
    func didCompleteDownloadWithError(model: NetworkRequestModel, task: URLSessionTask)
}

final class NetworkDownloadManager: NSObject {
    
    public var delegate: NetworkDownloadManagerDelegate?
    
    fileprivate var networkModel: NetworkRequestModel?
    fileprivate lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.networkDownloadManager.bigFileDownload")
        configuration.sessionSendsLaunchEvents = true
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue())
        return urlSession
    }()
    
    init(networkModel: NetworkRequestModel, delegate: NetworkDownloadManagerDelegate?) {
        super.init()
        self.delegate = delegate
        self.networkModel = networkModel
    }
    
    public func startDownload() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        var request = URLRequest(url: URL(string: (networkModel?.url)!)!)
        request.allHTTPHeaderFields = networkModel?.headers
        request.httpMethod = "GET"
        
        let task = session.downloadTask(with: request)
        task.resume()
    }
    
    public func cancelDownloadTask(_ task: URLSessionDownloadTask) {
        task.cancel { (data) in
            print("Resume data : - \(String(describing: data?.count))")
        }
    }
}

extension NetworkDownloadManager: URLSessionTaskDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            if totalBytesExpectedToWrite > 0 {
                let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
                self.delegate?.didUpdateDownloadInProgress(model: self.networkModel!, task: downloadTask, progress: progress)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            debugPrint("Location URL : - \(location)")
            self.delegate?.didFinishDownloading(model: self.networkModel!, task: downloadTask, location: location)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            self.delegate?.didCompleteDownloadWithError(model: self.networkModel!, task: task)
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        DispatchQueue.main.async {
        }
    }
}
