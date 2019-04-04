//
//  BaseTableViewController.swift
//  JKNews
//
//  Created by 欢瑞世纪 on 2019/3/27.
//  Copyright © 2019 欢瑞世纪. All rights reserved.
//

import UIKit

class BaseTableViewController: UITabBarController {

    let newsVC = NewsViewController()
    let videoVC = VideoViewController()
    let foundVC = FoundViewController()
    let meVC = MineViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

     let vcArr = [newsVC , videoVC , foundVC , meVC]
        let titlesArr = ["新闻" , "视频" , "发现" , "我的"]
        let imageName = ["xinwen","shipin","fa_xian","wode"]
        var toolBarItem = [UIBarButtonItem]()
        for (i,obj) in vcArr.enumerated() {
            
            let nav = BaseNavigationViewController.init(rootViewController: obj)
            nav.title = titlesArr[i]
            
            self.addChild(nav)
          
           let item = UITabBarItem.init(title: titlesArr[i], image: UIImage.init(named: imageName[i]), selectedImage: UIImage.init(named: imageName[i] + "-2"))

            obj.tabBarItem = item
            
        }
        self.tabBar.tintColor = HEXCOLOR(0xff9800)
        
    }
    

   

}
