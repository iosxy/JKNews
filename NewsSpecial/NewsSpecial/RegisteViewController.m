//
//  RegisteViewController.m
//  Product-PEWindow
//
//  Created by qianfeng on 16/4/26.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "RegisteViewController.h"
#import "MainDetailVC.h"
#define NUMPIC @"http://u1.tiyufeng.com/captcha?clientToken=7c98ddd1d8cb729bf66791a192b43748&randomParam=1461671598194"
@interface RegisteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *picTf;


@end

@implementation RegisteViewController
- (IBAction)sendNum:(id)sender {
    
    if ([_picTf.text isEqualToString:@""] || [_phoneTf.text isEqualToString:@""]){
        [self.view showLoadingMeg:@"请检查账号或者密码" time:1];
        return;
    }
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:_picTf.text forKey:_phoneTf.text];
    [self.view showLoadingMeg:@"注册成功" time:1];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)userAgreement:(UIButton *)sender {
    //用户协议

    MainDetailVC * vc = [[MainDetailVC alloc]init];
    vc.name = @"用户协议";
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
