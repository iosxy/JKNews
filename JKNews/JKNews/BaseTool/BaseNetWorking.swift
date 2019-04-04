//
//  BaseHNetWorking.swift
//  JKNews
//
//  Created by 欢瑞世纪 on 2019/3/27.
//  Copyright © 2019 欢瑞世纪. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import SwiftyJSON
class BaseNetWorking: NSObject {
    static let mainUrl = "https://a.rednet.cn/dispatch"
    
    static func request(uri: String = mainUrl, method: HTTPMethod = .post, parameters: [String: Any?]?) -> Promise<JSON> {
        
        var headers = ["Content-Type": "application/json","Accept":"application/json"]
        headers["userId"] = "KRimzlyNja6eTi5WxjiecA=="
        headers["Accept-Language"] = "zh-Hans-CN;q=1, en-CN;q=0.9"
        headers["identifier"] = "v/Cn9XNiZs3AHZQ85Nw5sMukeihtw1YcmXjeOrizE193K87HoZVPqaxb9QrZSO7d"
        headers["uuid"] = "3E1EB536264F4B72987402857BD3BBEC"
        headers["version"] = "7.1"
        headers["Accept-Encoding"] = "br, gzip, deflate"
       debugPrint(parameters)
        return Promise { fulfill, reject in
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 10
            manager.request(uri, method: method, parameters: parameters,encoding:JSONEncoding.default,headers:headers).responseJSON { (response) in
                
               debugPrint(response)
                if (response.result.value == nil) {
                    reject(NSError(domain: "test", code: 42, userInfo: [NSLocalizedDescriptionKey: "error"]))
                    
                    return
                }
               let object = JSON(response.result.value!)
                debugPrint(object)
            }
        }
    }


}




//
//Host    a.rednet.cn
//Content-Type    application/json
//version    7.1
//Accept    */*
// userId    KRimzlyNja6eTi5WxjiecA==
// terminal    2
// biztype    contentIndexDigest
// Accept-Language    zh-Hans-CN;q=1, en-CN;q=0.9
// identifier    v/Cn9XNiZs3AHZQ85Nw5sMukeihtw1YcmXjeOrizE193K87HoZVPqaxb9QrZSO7d
// Accept-Encoding    br, gzip, deflate
// uuid    3E1EB536264F4B72987402857BD3BBEC
// traceid
// User-Agent    News/7.1 (iPhone; iOS 12.1.4; Scale/3.00)
// sync
// bizop    queryIndexList
// Content-Length    77
// Connection    keep-alive
