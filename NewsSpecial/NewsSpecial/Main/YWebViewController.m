//
//  YWebViewController.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/24.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "YWebViewController.h"

@interface YWebViewController ()

@end

@implementation YWebViewController{
    NSString * _url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView * web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [web loadRequest:req];
}

-(void)loadUrl:(NSString * )url{
    _url = url;
}

@end
