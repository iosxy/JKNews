//
//  StarEightDetailViewController.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/24.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarEightDetailViewController.h"
#import "NewsTableViewCell.h"
#define DETAIL_URL @"http://api.app.happyjuzi.com/article/detail?accesstoken=5fc865056742c82430db621de55b1320&brand=Apple&carrier=2&id=%@&idfa=AD40CFA7-85B0-4ECB-A823-313C5F85C325&model=iPhone7Plus&net=wifi&pf=ios&res=414x736&system=12.1.4&uid=4363595144352692&ver=4.1"

@interface StarEightDetailViewController ()

@end

@implementation StarEightDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文章详情";
    
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"title"];
    [self.tableView registerClass:[NewsTextTableViewCell class] forCellReuseIdentifier:@"text"];
    [self.tableView registerClass:[NewsImageTableViewCell class] forCellReuseIdentifier:@"image"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
    [self YreloadData];
    [self YreloadData];
    
}
- (void)YreloadData{
    [self.tableView.header endRefreshing];
    
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:DETAIL_URL,self.contentId] andParamter:@{} returnData:^(NSData *data, NSError *error) {
        
        if (!error) {
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            NSLog(@"%@",dic);
            [self.dataList removeAllObjects];
            [self.dataList addObject:dic[@"data"][@"info"]];
            
            
            NSString * contents = dic[@"data"][@"contents"];
            NSMutableArray * strArr = [contents componentsSeparatedByString:@"</p><p>"];
            
            [self.dataList addObjectsFromArray:strArr];
            [self.dataList addObjectsFromArray:dic[@"data"][@"resources"][@"IMG"]];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}
- (void)YloadMoreData{
    
    [self.tableView.footer endRefreshing];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath];
        
        [cell loadData:self.dataList[indexPath.row]];
        return cell;
        
    }else {
        
        id item = self.dataList[indexPath.row];
        if ([item isKindOfClass:[NSDictionary class]]) {
            NewsImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"image" forIndexPath:indexPath];
            [cell loadData:self.dataList[indexPath.row]];
            return cell;
        }else {
            
            NewsTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"text" forIndexPath:indexPath];
            [cell loadData:self.dataList[indexPath.row]];
            return cell;
            
            
        }
        
        
        
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 100;
    }else {
        return  UITableViewAutomaticDimension;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return  self.dataList.count;
    
    
}




@end
