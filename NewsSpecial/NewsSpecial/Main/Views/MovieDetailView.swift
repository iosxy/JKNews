//
//  MovieDetailView.swift
//  Yuwan
//
//  Created by lqs on 2017/7/12.
//  Copyright © 2017年 lqs. All rights reserved.
//

import UIKit
import SwiftyJSON
class MovieDetailView: UIView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var actorScrollView: UIScrollView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var mainActorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var seeCountLabel: UILabel!
    
    @IBOutlet weak var rankLable: UILabel!
    
    @IBOutlet weak var photoContentView: UIScrollView!
    
    @IBOutlet weak var voteButton: UIButton!
    var item: JSON? = nil
    var movie: JSON? = nil
//    var viewDidLoad : shareBlock?
    let shadowLayer = CAShapeLayer()
    var id: String? = nil
    var type: String? = nil
    @objc public var nav : UINavigationController!
    weak var tableView: UITableView? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 6
        containerView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        shadowLayer.path = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 6).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 2.0)
        shadowLayer.shadowOpacity = 0.22
        shadowLayer.shadowRadius = 4
        
    }
    
    @IBAction func play(_ sender: Any) {
        let movie = item!["detail"]["movie"] != .null ? item!["detail"]["movie"] : item!["detail"]["tv"]
        let url = movie["url"].stringValue
        if url != "" {

            let vc = YWebViewController()
            vc.loadUrl(url)
            self.nav.pushViewController(vc, animated: true)
        }
    }

    @IBAction func expandDescription(_ sender: Any) {
        tableView?.beginUpdates()
        descriptionLabel.numberOfLines = 0
        tableView?.endUpdates()
        
        expandButton.isHidden = true
        
    }
    
    @objc public func loadDataWithId(id : String) {

        YCHNetworking.postStartRequest(fromUrl: "http://ywapp.hryouxi.com/yuwanapi/app/getContent", andParamter: ["id" : id , "userId" : "" ]) { (data, error) in
          
            let dic = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 1))
            let json = JSON.init(dic)
            self.loadItem(json["data"])
            
        };
        
        
        
//        HRAPI_NEW.post(YWNETNEW_getContent, ["id" : id , "userId" : HRAPI_NEW.getUserModels()?.id == nil ? "" : HRAPI_NEW.getUserModels()?.id ]).then {[weak self] item -> Void in
//
//            self?.loadItem(item)
//
//            }.catch { (error) in
//                if self.viewDidLoad != nil {
//                    self.viewDidLoad!(false)
//                }
//        }

    }
    
    func loadItem(_ item: JSON ) {

        self.id = item["id"].stringValue
        self.item = item
        if (item["detail"]["movie"] != .null) {
            self.type = "movie"
        } else {
            self.type = "tv"
        }
        let movie = item["detail"][self.type!]
        self.movie = movie
        self.seeCountLabel.text = item["number"].stringValue
        self.backgroundImageView.ysd_setImage(with: movie["background"]["url"].stringValue)
        self.coverImageView.ysd_setImage(with: movie["cover"]["url"].stringValue)

        self.titleLabel.text = movie["name"].stringValue
        self.directorLabel.text = movie["directors"].stringValue
        self.mainActorLabel.text = movie["majorStar"].stringValue
        self.typeLabel.text = movie["type"].stringValue
        if !movie["publishTimeStr"].stringValue.isEmpty {
            self.releaseDateLabel.text = movie["publishTimeStr"].stringValue
        } else {
            //self.releaseDateLabel.text = Utils.getDate(movie["publishTime"].int64Value)
        }

        self.descriptionLabel.text = movie["description"].stringValue
        self.expandButton.isHidden = true
        let url = movie["url"].url
        if url != nil && !(url?.absoluteString.isEmpty)! {
            self.playButton.isHidden = false
        } else {
            self.playButton.isHidden = true
        }
    //    var lastView: HRVerticalWorkView? = nil
        for starItem in movie["starItems"].arrayValue {
//            let view = HRVerticalWorkView.loadFromNib()
//            view.loadStarJsonItem(starItem)
//
//            self.actorScrollView.addSubview(view)
//            view.snp.makeConstraints({ (make) in
//                make.top.equalToSuperview()
//                make.height.lessThanOrEqualToSuperview()
//                make.bottom.lessThanOrEqualToSuperview()
//
//                if lastView == nil {
//                    make.left.equalToSuperview().offset(14)
//                } else {
//                    make.left.equalTo(lastView!.snp.right).offset(10)
//                }
//                make.right.lessThanOrEqualToSuperview().offset(-14)
//            })
//
//            lastView = view
        }

//        for (i,photo) in movie["photos"].arrayValue.enumerated() {
//            let aspectRatio = Utils.calcAspectRatio(image: photo)
//
//            let imageView = UIImageView()
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.isUserInteractionEnabled = true
//            self.photoContainerView.addChildView(imageView)
//            imageView.yw_setImage(with: photo["url"].url)
//            imageView.snp.makeConstraints({ (make) in
//                make.width.equalTo(imageView.snp.height).multipliedBy(aspectRatio)
//            })
//            imageView.tag = i
//            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(_:))))
//        }


    }
    @IBAction func voteClick(_ sender: Any) {
        

    }
    
    func getContentId() -> String {
        return id!
    }

}
