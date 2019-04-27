//
//  StarBallDetailViewController.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/23.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarBallDetailViewController.h"

@interface StarBallDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *hot;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UILabel *infoLeft;
@property (weak, nonatomic) IBOutlet UILabel *infoRight;
@property (weak, nonatomic) IBOutlet UILabel *soccer;

@end

@implementation StarBallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"星球";
    
 
    [self reloadData];
    
}

-(void)reloadData{
    
    
    [YCHNetworking postStartRequestFromUrl:@"http://ywapp.hryouxi.com/yuwanapi/app/getStar" andParamter:@{@"starId" : self.contentId , @"userId" : @""} returnData:^(NSData *data, NSError *error) {
        
        if (!error) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            [self refreshUI:dic];
            NSLog(@"%@",dic);
            
        }
        
        
    }];
    
//    HRAPI_NEW.post(YWNETNEW_getStar, [ "starId" : star["star"]["id"].stringValue , "userId" : HRAPI_NEW.getUserModels()?.id]).then{ response -> Void in
//                    self.bindStar(response)
//                    self.followerCountLabel.text = Utils.shortNumberString(response["star"]["likecount"].numberValue)
//
//                }
    
    
}

- (void)refreshUI:(NSDictionary * )dic {
    
    NSDictionary * star = dic[@"data"][@"star"];
    
    [self.cover ysd_setImageWithString:star[@"avatar"]];
    self.name.text = star[@"name"];
    self.hot.text = [@"热度" stringByAppendingString:[star[@"likecount"] stringValue]];
    self.introduce.text = [@"个人简介: " stringByAppendingString:star[@"description"]];
    
    NSMutableString * leftInfo = [NSMutableString string];
    [leftInfo appendFormat:@"中文名: "];
    [leftInfo appendFormat:star[@"chineseName"]];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"国籍: "];
    [leftInfo appendFormat:star[@"country"]];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"星座: "];
    [leftInfo appendFormat:star[@"constellation"]];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"出生地: "];
    [leftInfo appendFormat:star[@"birthPlace"]];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"身高: "];
    [leftInfo appendFormat:[star[@"height"] stringValue]];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"毕业院校: "];
    [leftInfo appendFormat:star[@"school"]];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@"\n"];
    [leftInfo appendFormat:@""];
    self.infoLeft.text = leftInfo;
    
    NSMutableString * rightInfo = [NSMutableString string];
    [rightInfo appendFormat:@"英文名: "];
    [rightInfo appendFormat:star[@"englishName"]];
    [rightInfo appendFormat:@"\n\n"];
    [rightInfo appendFormat:@"民族: "];
    [rightInfo appendFormat:star[@"nationality"]];
    [rightInfo appendFormat:@"\n\n"];
    [rightInfo appendFormat:@"血型: "];
    [rightInfo appendFormat:star[@"bloodType"]];
    [rightInfo appendFormat:@"\n\n"];
    [rightInfo appendFormat:@"体重: "];
    [rightInfo appendFormat:[star[@"weight"] stringValue]];
    [rightInfo appendFormat:@"\n\n"];
    [rightInfo appendFormat:@"生日: "];
    [rightInfo appendFormat:star[@"birthDateStr"]];
    [rightInfo appendFormat:@"\n\n"];
    [rightInfo appendFormat:@"经济公司: "];
    [rightInfo appendFormat:star[@"agency"]];
    
    self.infoRight.text = rightInfo;
    
    NSString * reward = star[@"reward"];
    
    NSArray * arr = [reward componentsSeparatedByString:@"|"];
    NSMutableString * rewardStr = [NSMutableString string];
    for (NSString * obj in arr) {
        
        [rewardStr appendFormat:obj];
        [rewardStr appendFormat:@"\n\n"];
        
    }
    
    self.soccer.text = rewardStr;
    
    
    
//    agency = "\U5927\U7897\U5a31\U4e50";
//    alias = "";
//    avatar = "http://ywimage.hryouxi.com/65f7cbd6b0415cd50e4bd6fe2933adf4_340_340.jpeg";
//    birthDate = 601401600;
//    birthDateStr = "1989-01-22";
//    birthPlace = "\U8fbd\U5b81\U7701\U6c88\U9633\U5e02";
//    bloodType = "";
//    career = "";
//    chineseName = "\U4f55\U6b22";
//    constellation = "\U6c34\U74f6\U5ea7";
//    country = "\U4e2d\U56fd";
//    description = "\U4e2d\U56fd\U5185\U5730\U7537\U6f14\U5458\Uff0c\U5927\U7897\U5a31\U4e50\U7b7e\U7ea6\U6f14\U5458\U3002";
//    editorLikeCount = 24134;
//    englishName = "Huan He";
//    gender = MALE;
//    height = 178;
//    id = 640;
//    likecount = 24134;
//    name = "\U4f55\U6b22";
//    nationality = "\U6c49\U65cf";
//    rank = 811;
//    reward = "";
//    school = "\U4e1c\U5317\U5e08\U8303\U5927\U5b66";
//    social = "{\"weibo\": \"https://weibo.com/u/1664462475\", \"weixin\": \"\", \"jinritoutiao\": \"\", \"bilibili\": \"\", \"zhihu\": \"\", \"qqzone\": \"\"}";
//    subscribeCount = 0;
//    tagId = 7;
//    time = "<null>";
//    type = STAR;
//    weight = 70;
    
    
    
    
}
@end
