//
//  NewsViewController.swift
//  JKNews
//
//  Created by 欢瑞世纪 on 2019/3/27.
//  Copyright © 2019 欢瑞世纪. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新闻"
        
        BaseNetWorking.request(parameters: ["siteId":"6","areaCode":"1018","channelId":"5175","pageSize":20 ,"datetime":nil])
        
        
    }
    

   

}
