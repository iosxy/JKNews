//
//  UserModel.m
//  NewsSpecial
//
//  Created by 游成虎 on 2019/4/23.
//  Copyright © 2019年 GetOn. All rights reserved.
//

#import "UserModel.h"

static UserModel *currentUser = nil;

@implementation UserModel

+(UserModel*) currentUser{
    return currentUser;
}
+(void) setCurrentUser:(UserModel*)user{
    if (user) {
        currentUser = user;
    }
}

@end
