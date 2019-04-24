//
//  MineViewController.m
//  weiliao
//
//  Created by 游成虎 on 16/11/2.
//  Copyright © 2016年 游成虎. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell1.h"
#import "MineTableViewCell2.h"
#import "EditDataVC.h"
#import "chargeVC.h"
#import "LoginViewController.h"
#import "MainDetailVC.h"

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
@interface MineViewController ()

@property (nonatomic,strong) NSMutableArray * listArray;

@end

@implementation MineViewController
{
    UITableView *_mineTableView;
    EditDataVC *_editDataVC;
    NSString * _sizeStr;
}
- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"isLogin"]isEqualToString:@"isLogin"]) {
        _isLogin = YES;
    }else{
        _isLogin = NO;
    }
    NSDictionary*dic=[[UserModel currentUser] keyValues];
    [user setObject:dic forKey:@"currentUser"];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addDataSource];
    [self addTableView];
    
}
- (void)addDataSource
{
    NSArray * arr0 = @[@"头像"];
    NSArray * arr1 = @[@{@"title":@"用户协议",@"image":@"用户协议"},@{@"title":@"清空缓存",@"image":@"清空缓存"}];
    NSArray * arr2 = @[@{@"title":@"意见反馈",@"image":@"意见反馈"},@{@"title":@"退出登录",@"image":@"退出登录"}];
    [self.listArray addObject:arr0];
    [self.listArray addObject:arr1];
    [self.listArray addObject:arr2];
}
- (void)addTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell2" bundle:nil] forCellReuseIdentifier:@"MineTableViewCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell1" bundle:nil] forCellReuseIdentifier:@"MineTableViewCell1"];
    [self.view addSubview:self.tableView];
    [self.tableView.header removeFromSuperview];
    [self.tableView.footer removeFromSuperview];
    
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listArray[section] count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    }else {
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MineTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_isLogin) {
            UserModel * user = [UserModel currentUser];
            cell.nickName.text = user.nickName;
            if (user.gender.length) {
                cell.genderLabel.text = [user.gender isEqualToString:@"1"] ? @"男":@"女";
            }else {
                cell.genderLabel.text = @"未知";
            }
            cell.signLabel.text = user.sign.length?user.sign:@"写个签名吧~";
            cell.idLabel.text = @"87542u56";
            if (user.userLogo.length) {
                cell.headerImageView.image = [[UIImage alloc]initWithContentsOfFile:user.userLogo];
            }
        }else {
            cell.nickName.text = @"请登录";
            cell.signLabel.text = @"签名未知";
            cell.genderLabel.text = @"未知";
            cell.idLabel.text = @"id未知";
        }
        return cell;
    }else
    {
        MineTableViewCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell1" forIndexPath:indexPath];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name.text = self.listArray[indexPath.section][indexPath.row][@"title"];
        cell.leftImage.image = [UIImage imageNamed:self.listArray[indexPath.section][indexPath.row][@"image"]];

        if (indexPath.section == 2 && indexPath.row == 1) {
            cell.rightLabel.hidden = YES;
        }
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //个人信息
        if (_isLogin) {
            _editDataVC = [[EditDataVC alloc]init];
            _editDataVC.title = @"个人信息";
            _editDataVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:_editDataVC animated:YES];
        }else {
            LoginViewController * vc = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        MainDetailVC * vc = [[MainDetailVC alloc]init];
        vc.name = @"用户协议";
        [self.navigationController pushViewController:vc animated:NO];
        
    }else if (indexPath.section == 1 && indexPath.row == 1)
    {
        [self clearButtonClick];
        
    }else if (indexPath.section == 2 && indexPath.row == 0)
    {
        if (_isLogin == NO) {
            [self.view showLoadingMeg:@"请先登录" time:1];
            return;
        }
        MainDetailVC * vc = [[MainDetailVC alloc]init];
        vc.name = @"意见反馈";
        [self.navigationController pushViewController:vc animated:NO];
        
    }else {
       //退出登录
        MainDetailVC * vc = [[MainDetailVC alloc]init];
        vc.name = @"退出登录";
        [self.navigationController pushViewController:vc animated:NO];
        
    }
    
}
- (void)clearButtonClick
{
    [[SDImageCache sharedImageCache]clearDisk];
    [[SDImageCache sharedImageCache]clearDisk];
    [self.view showLoadingMeg:@"清空缓存成功" time:1];
    _sizeStr = [NSString stringWithFormat:@"%0.2fM",[self folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches/default",NSHomeDirectory()]]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }else {
        return 5;
    }
}

#pragma mark - lazy load
- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
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
