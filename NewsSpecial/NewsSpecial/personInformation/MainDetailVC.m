//
//  MainDetailVC.m
//  Product-PEWindow
//
//  Created by qianfeng on 16/4/25.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "MainDetailVC.h"
#define SEARCH_URL @"http://u1.tiyufeng.com/section/content_list?portalId=15&contentType=%@&start=0&id=438&limit=18&clientToken=7c98ddd1d8cb729bf66791a192b43748&keywords=%@"

@interface MainDetailVC ()<UITableViewDataSource, UISearchBarDelegate,UITableViewDelegate>
/** 数据源*/
@property(nonatomic,strong)NSMutableArray * dataSource;
/** tablevIUe*/
@property(nonatomic,strong)UITableView * tabelView;

@end

@implementation MainDetailVC{
    UISearchBar * _search;
    UILabel * _sizeLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    if ([self.name isEqualToString:@"客服"]){
        [self loadPhone];
    }else if ([self.name isEqualToString:@"退出登录"]){
        [self loadSetting];
    }else if ([self.name isEqualToString:@"意见反馈"]){
        [self loadFavoriteView];
    }
    else if ([self.name isEqualToString:@"用户协议"]){
        [self loadProtocols];
    }
    else if ([self.name isEqualToString:@"清空缓存"]){
        [self loadSetting];
    }
}
- (void)loadProtocols {
    self.title = @"用户协议";
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"隐私权政策" ofType:@"html"];
//
//    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//
//    NSString *basePath = [[NSBundle mainBundle] bundlePath];
//
//    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
//
//    [webView loadHTMLString:htmlString baseURL:baseURL];
    
    [webView loadRequest: [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://js.7018999.com/2019/ys424.html"]]];
    
    
}
- (void)loadFavoriteView
{
    UITextView * label = [[UITextView alloc]initWithFrame:CGRectMake(15, 150, [[UIScreen mainScreen]bounds].size.width - 30, 180)];
    label.text = @"您的建议：";
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.textColor = PrinkColor;
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 180 + 150 + 10, 60, 30)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tijiaoClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)tijiaoClicked {
    [self.view showLoadingMeg:@"提交成功" time:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)loadPhone
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width, 300)];
    label.text = @"客户服务邮箱:iosxysina.com/n我们在收到邮件之后会尽快回复您!";
    label.textColor = [UIColor brownColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
}
- (void)loadSetting
{
    UIButton * button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    button.layer.cornerRadius = 50;
    button.clipsToBounds = YES;
    
    [button setTitle:@"清空缓存" forState:UIControlStateNormal];
    [button setTitleColor:RGB(0x333333) forState:UIControlStateNormal];
    [button setTitleColor:RGB(0x999999) forState:UIControlStateHighlighted];
    button.backgroundColor = RGB(0xf6f6f6);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    _sizeLabel = [[UILabel alloc]init];
    _sizeLabel.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) + 20, 100, 40);
   
    _sizeLabel.text = [NSString stringWithFormat:@"%0.2fM",[self folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches/default",NSHomeDirectory()]]];
    NSLog(@"%@",NSHomeDirectory());
    _sizeLabel.textColor = RGB(0x333333);
    _sizeLabel.backgroundColor = RGB(0xf6f6f6);
    _sizeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_sizeLabel];
    [self.view addSubview:button];
    
    UIButton * outButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_sizeLabel.frame) + 30, self.view.frame.size.width - 40, 40)];
    [outButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.view addSubview:outButton];
    [outButton addTarget:self action:@selector(outClick) forControlEvents:UIControlEventTouchUpInside];
    [outButton setBackgroundColor:RGB(0x64d3d8)];
    
}
- (void)outClick{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [self.view showLoadingMeg:@"退出成功!" time:1];
    [user setObject:@"noLogin" forKey:@"isLogin"];
    [user removeObjectForKey:@"currentUser"];
    [self.navigationController popViewControllerAnimated:true];
    
}
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    //通过枚举遍历法遍历文件夹中的所有文件
    //创建枚举遍历器
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    //首先声明文件名称、文件大小
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        //得到当前遍历文件的路径
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        //调用封装好的获取单个文件大小的方法
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);//转换为多少M进行返回
}
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (void)buttonClick
{
    [[SDImageCache sharedImageCache]clearDisk];
    [[SDImageCache sharedImageCache]clearDisk];
    [self.view showLoadingMeg:@"清空缓存成功" time:1];
    _sizeLabel.text = [NSString stringWithFormat:@"%0.2fM",[self folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches/default",NSHomeDirectory()]]];
}

- (BOOL)hidesBottomBarWhenPushed{
    return YES;
}

@end
