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
//  LargeFileViewController.swift
//  iOS-Vitals
//
//  Created by Vineet Ravi on 26/04/18.
//  Copyright © 2018 Vineet Ravi. All rights reserved.
//


import UIKit

class LargeFileViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    var runningTask: URLSessionDownloadTask?
    var download: NetworkDownloadManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func terminateAppClicked(_ sender: UIButton) {
        exit(0)
    }
    
    @IBAction func startDownloadButtonClicked(sender: UIButton) {
        let model = NetworkRequestModel(url: "http://imagomat.de/testimages/1.tiff", httpMethod: .GET, body: nil, headers: nil)
        download = NetworkDownloadManager.init(networkModel: model, delegate: self)
        download?.startDownload()
    }
    
    @IBAction func cancelTask() {
        if let mRunningtask = runningTask {
            download?.cancelDownloadTask(mRunningtask)
        }
    }
}

extension LargeFileViewController: NetworkDownloadManagerDelegate {
    func didUpdateDownloadInProgress(model: NetworkRequestModel, task: URLSessionDownloadTask, progress: Float) {
        debugPrint("Progress for: \(progress * 100) %")
        runningTask = task
        progressView.progress = progress
    }
    
    func didFinishDownloading(model: NetworkRequestModel, task: URLSessionDownloadTask, location: URL) {
        debugPrint("Finished downloading. LOCATION :- \(location)")
    }
    
    func didCompleteDownloadWithError(model: NetworkRequestModel, task: URLSessionTask) {
    }
}
