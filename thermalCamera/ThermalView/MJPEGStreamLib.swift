//
//  MjpegStreamLib.swift
//  Pods
//
//  Created by Kuray ÖĞÜN on 24/08/2017.
//
//

import UIKit

open class MJPEGStreamLib: NSObject, URLSessionDataDelegate {

    fileprivate enum StreamStatus {
        case stop
        case loading
        case play
    }
    
    fileprivate var receivedData: NSMutableData?
    fileprivate var dataTask: URLSessionDataTask?
    fileprivate var session: Foundation.URLSession!
    fileprivate var status: StreamStatus = .stop
    
    open var authenticationHandler: ((URLAuthenticationChallenge) -> (Foundation.URLSession.AuthChallengeDisposition, URLCredential?))?
    open var didStartLoading: (()->Void)?
    open var didFinishLoading: (()->Void)?
    open var contentURL: URL?
    open var imageView: UIImageView
    open var object_view: Int32
    
    public init(imageView: UIImageView) {
        self.imageView = imageView
        self.object_view = -1
        super.init()
        //self.object_view = -1
        self.session = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }
    
    public convenience init(imageView: UIImageView, contentURL: URL) {
        self.init(imageView: imageView)
        self.contentURL = contentURL
        //self.object_view = -1
    }
    
    deinit {
        dataTask?.cancel()
    }
    
    // Play function with url parameter
    open func play(url: URL){
        // Checking the status for it is already playing or not
        if status == .play || status == .loading {
            stop()
        }
        contentURL = url
        play()
    }
    
    // Play function without URL paremeter
    open func play() {
        guard let url = contentURL , status == .stop else {
            return
        }
        
        status = .loading
        DispatchQueue.main.async { self.didStartLoading?() }
        
        receivedData = NSMutableData()
        let request = URLRequest(url: url)
        dataTask = session.dataTask(with: request)
        dataTask?.resume()
    }
    
    // Stop the stream function
    open func stop(){
        status = .stop
        dataTask?.cancel()
    }
    open func change_view(data: Int32) {
        self.object_view = data
    }
    open func get_view() -> Int32 {
        return self.object_view
    }
    
    // NSURLSessionDataDelegate
    
    open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        // Controlling the imageData is not nil
        if let imageData = receivedData , imageData.length > 0,
            let receivedImage = UIImage(data: imageData as Data) {
            if status == .loading {
                status = .play
                DispatchQueue.main.async { self.didFinishLoading?() }
            }
            
            // THis is Where I set the Type of Image we are going to get from the settings
            // Start as Grey Scale and change to whatever the user wants.
            // Popup Screen when the user is interested
            
            // Set the imageview as received stream
            DispatchQueue.main.async { self.imageView.image = OpenCVWrapper.toGray(receivedImage, display: Int32(color_scheme)) } //print(self.imageView.image) }
        }
        
        receivedData = NSMutableData()
        completionHandler(.allow)
    }
    
    open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        receivedData?.append(data)
    }
    
    // NSURLSessionTaskDelegate
    
    open func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        var credential: URLCredential?
        var disposition: Foundation.URLSession.AuthChallengeDisposition = .performDefaultHandling
        // Getting the authentication if stream asks it
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let trust = challenge.protectionSpace.serverTrust {
                credential = URLCredential(trust: trust)
                disposition = .useCredential
            }
        } else if let onAuthentication = authenticationHandler {
            (disposition, credential) = onAuthentication(challenge)
        }
        
        completionHandler(disposition, credential)
    }
}
