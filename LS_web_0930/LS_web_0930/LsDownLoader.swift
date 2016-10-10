//
//  LsDownLoader.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
protocol LsDownLoaderDelegate:NSObjectProtocol {
    func lsdownloader(downloader:LsDownLoader,didFailWithError error:NSError)
    func lsdownloader(downloader:LsDownLoader,didFinishWithData data:NSData)
}
class LsDownLoader: NSObject {
    weak var delegate:LsDownLoaderDelegate?
    var type:Int?
    func lsDownloadWithURLString(urlString:String){
        
            let url = NSURL(string: urlString)
            let request = NSURLRequest(URL: url!)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (data, response, error) in
                if let tmpError = error{
                   self.delegate?.lsdownloader(self, didFailWithError: tmpError)
                }else{
                    let httpResponse = response as! NSHTTPURLResponse
                    if httpResponse.statusCode == 200 {
                        self.delegate?.lsdownloader(self, didFinishWithData: data!)
                        
                    }else{
                        let error = NSError(domain: urlString, code: httpResponse.statusCode, userInfo: ["msg":"下载失败"])
                        self.delegate?.lsdownloader(self, didFailWithError: error)
                    }
                }
            }
            task.resume()
            
        }
}
