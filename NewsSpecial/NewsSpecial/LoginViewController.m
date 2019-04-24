//
//  LoginViewController.m
//  Product-PEWindow
//
//  Created by qianfeng on 16/4/26.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.navigationController.navigationBar.tintColor =[UIColor blackColor];
    self.login.layer.cornerRadius = 5;
    self.login.clipsToBounds = YES;
    self.registe.layer.cornerRadius = 5;
    self.registe.clipsToBounds = YES;
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:_phoneTf.text] isEqualToString:_mimaTf.text]) {
        [self.view showLoadingMeg:@"登陆成功" time:1];
        [user setObject:@"isLogin" forKey:@"isLogin"];
        [UserModel currentUser].nickName = @"用户3847892";
        NSDictionary*dic=[[UserModel currentUser] keyValues];
        [user setObject:dic forKey:@"currentUser"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.view showLoadingMeg:@"登陆失败" time:1];
        [user setObject:@"noLogin" forKey:@"isLogin"];
    }
}
- (IBAction)registe:(id)sender {
    RegisteViewController * vc = [[RegisteViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
