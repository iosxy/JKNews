//
//  UserModel.h
//  NewsSpecial
//
//  Created by 游成虎 on 2019/4/23.
//  Copyright © 2019年 GetOn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

+ (UserModel *)currentUser;
+(void) setCurrentUser:(UserModel*)user;
/**id号**/
@property (nonatomic,copy) NSString *yId;
/**性别 0-女,1-男**/
@property (nonatomic,copy) NSString *gender;
/**昵称**/
@property (nonatomic,copy) NSString *nickName;
/**头像 头像图片ID**/
@property (nonatomic,copy) NSString *userLogo;
/**个性签名**/
@property (nonatomic,copy) NSString *sign;

@end

NS_ASSUME_NONNULL_END
