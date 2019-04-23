//
//  YuwanCardHeaderView.swift
//  Yuwan
//
//  Created by lqs on 2017/6/14.
//  Copyright © 2017年 lqs. All rights reserved.
//

import UIKit

class YuwanCardHeaderView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var genderImageView: UIImageView!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var subscribeButton: UIButton!
    
  //  let starDetailView = StarDetailView.loadFromNib()
    
    @IBOutlet weak var detailContainerView: UIView!
    
    //private var star: JSON? = nil
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet var detailContainerHeightConstraint: NSLayoutConstraint!

    let shadowLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        container.layer.cornerRadius = 6
        
       // detailContainerView.addSubview(starDetailView)
//        starDetailView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
////            make.height.equalTo(0)
//        }
//        detailContainerHeightConstraint.isActive = false
        
        
        container.layer.insertSublayer(shadowLayer, at: 0)
        //layer.insertSublayer(shadowLayer, below: nil) // also works
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowLayer.path = UIBezierPath(roundedRect: container.bounds, cornerRadius: 6).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor(red: 1, green: 0x98/255.0, blue: 0, alpha: 1).cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 2.0)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 6
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "height_toggle"), object: nil)
        
    }
    
    @IBAction func expand(_ sender: Any) {
        if detailContainerHeightConstraint.isActive {
            detailContainerHeightConstraint.isActive = false
            detailContainerView.isHidden = false
            expandButton.setTitle("收起", for: .normal)
            expandButton.setImage(UIImage(named:"card_icon_packup"), for: .normal)
        } else {
            detailContainerHeightConstraint.isActive = true
            detailContainerView.isHidden = true
            expandButton.setTitle("详细资料", for: .normal)
            expandButton.setImage(UIImage(named:"card_icon_more"), for: .normal)
        }
        self.layoutSubviews()
    }
//    func loadStar(_ star: JSON) {
//
//
//        HRAPI_NEW.post(YWNETNEW_getStar, [ "starId" : star["star"]["id"].stringValue , "userId" : HRAPI_NEW.getUserModels()?.id]).then{ response -> Void in
//            self.bindStar(response)
//            self.followerCountLabel.text = Utils.shortNumberString(response["star"]["likecount"].numberValue)
//
//        }
//
//       // YWAPI.get("/star/star", ["starId": star["star"]["id"].stringValue]).then
////
////        YWAPI_NEW.post(YWNETNEW_getStarLikeCount, ["starId" : star["star"]["id"].stringValue]).then { respone -> Void in
////        }
////
//
//
//    }
//    func bindStar(_ star: JSON) {
//        self.star = star
//        defaultFollowStatus = star["isSubscribe"].boolValue
//        subscribeButton.isSelected = star["isSubscribe"].boolValue
//        nameLabel.text = star["star"]["name"].stringValue
//        photoImageView.yw_setImage(with: star["star"]["avatar"].url)
//        if (star["star"]["gender"].stringValue == "FEMALE") {
//            genderImageView.image = #imageLiteral(resourceName: "card_icon_girl")
//        }
//        let descriptionString = NSMutableAttributedString()
//      descriptionString.append(NSMutableAttributedString(string: "个人简介：", attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 0x73/255.0, alpha: 1)]))
//      descriptionString.append(NSMutableAttributedString(string: star["star"]["description"].stringValue, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 0x0f/255.0, alpha: 1)]))
//
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 7
//      descriptionString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: descriptionString.string.characters.count))
//
//        descriptionLabel.attributedText = descriptionString
//
//
//        let basicInfoView = starDetailView.basicInfoView!
//        if !star["star"]["chineseName"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "中文名：", value: star["star"]["chineseName"].stringValue)
//        }
//        if !star["star"]["englishName"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "英文名：", value: star["star"]["englishName"].stringValue)
//        }
//        if !star["star"]["alias"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "昵称：", value: star["star"]["alias"].stringValue)
//        }
//        if !star["star"]["country"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "国籍：", value: star["star"]["country"].stringValue)
//        }
//        if !star["star"]["nationality"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "民族：", value: star["star"]["nationality"].stringValue)
//        }
//        if !star["star"]["constellation"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "星座：", value: star["star"]["constellation"].stringValue)
//        }
//        if !star["star"]["bloodType"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "血型：", value: star["star"]["bloodType"].stringValue)
//        }
//        if !star["star"]["birthPlace"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "出生地：", value: star["star"]["birthPlace"].stringValue)
//        }
//        if star["star"]["weight"].doubleValue > 0 {
//            basicInfoView.addItem(name: "体重：", value: star["star"]["weight"].stringValue + " kg")
//        }
//        if star["star"]["height"].doubleValue > 0 {
//            basicInfoView.addItem(name: "身高：", value: star["star"]["height"].stringValue + " cm")
//        }
//        if !star["star"]["birthDateStr"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "生日：", value: star["star"]["birthDateStr"].stringValue)
//        } else if star["star"]["birthDate"].int64Value > 0 {
//            basicInfoView.addItem(name: "生日：", value: Utils.getDate(star["star"]["birthDate"].int64Value))
//
//        }
//        if !star["star"]["career"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "特长：", value: star["star"]["career"].stringValue)
//        }
//        if !star["star"]["school"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "毕业院校：", value: star["star"]["school"].stringValue)
//        }
//        if !star["star"]["agency"].stringValue.isEmpty {
//            basicInfoView.addItem(name: "经纪公司：", value: star["star"]["agency"].stringValue)
//        }
//
//        let awardView = starDetailView.awardView!
//
//        let rewardStr = star["star"]["reward"].stringValue
//        for rewardItemStr in rewardStr.characters.split(separator: "|") {
//            let reward = rewardItemStr.split(separator: " ")
//            if (reward.count >= 2) {
//                awardView.addItem(date: String(reward[0]), description: String(reward[1]))
//            }
//        }
//    }
    
//    @IBAction func toggleSubscribe(_ sender: Any) {
//        if (HRAPI.getAuth() == nil) {
//            let vc = HRRootNavigationController(rootViewController: HRLoginViewController())
//            Utils.getNavigationController().present(vc, animated: true)
//            return
//        }
//        if star == nil {
//            return;
//        }
//        let newValue = !star!["isSubscribe"].boolValue
//
//
//        HRAPI_NEW.post(YWNETNEW_subscribe, ["userId":HRAPI_NEW.getUserModels()?.id,"starId":star!["star"]["id"].stringValue]).then { respone -> Void in
//
//            if respone["subscribeReward"].intValue != 0 {
//
//                SignToast.show(addTo: (Utils.getCurrentViewController()?.view)!, animated: true, count: String(respone["subscribeReward"].intValue), title: "关注"+String(respone["subscribeNumber"].intValue)+"个娱丸卡")
//
//            }
//
//        }
//
//        star!["isSubscribe"].boolValue = newValue
//        loadSubscribeStatus()
//    }
    var defaultFollowStatus : Bool!
//    private func loadSubscribeStatus() {
//        subscribeButton.isSelected = star!["isSubscribe"].boolValue
//
//        if self.defaultFollowStatus {
//            if subscribeButton.isSelected {
//
//                self.followerCountLabel.text = Utils.shortNumberString(NSNumber.init(value: self.star!["star"]["likecount"].intValue))
//            }else {
//                self.followerCountLabel.text = Utils.shortNumberString(NSNumber.init(value: self.star!["star"]["likecount"].intValue - 1))
//
//            }
//        }else {
//            if subscribeButton.isSelected {
//
//                self.followerCountLabel.text = Utils.shortNumberString(NSNumber.init(value: self.star!["star"]["likecount"].intValue + 1))
//            }else {
//                self.followerCountLabel.text = Utils.shortNumberString(NSNumber.init(value: self.star!["star"]["likecount"].intValue))
//
//            }
//        }
//
//    }
}
