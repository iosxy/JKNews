//
//  StarNewsDetailViewController.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/24.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarNewsDetailViewController.h"
#import "NewsTableViewCell.h"

#define NEWS_DETAIL @"http://ywapp.hryouxi.com/yuwanapi/app/getContent"

@interface StarNewsDetailViewController ()

@end

@implementation StarNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文章详情";
    
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"title"];
    [self.tableView registerClass:[NewsTextTableViewCell class] forCellReuseIdentifier:@"text"];
    [self.tableView registerClass:[NewsImageTableViewCell class] forCellReuseIdentifier:@"image"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 300;
    [self YreloadData];
    
}

- (void)YreloadData {
    
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:NEWS_DETAIL] andParamter:@{@"id":self.contentId, @"userId" : @""} returnData:^(NSData *data, NSError *error) {
        if (!error) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            [self.dataList removeAllObjects];
            
            [self.dataList addObject:dic[@"data"][@"detail"][@"article"]];
            
            [self.dataList addObjectsFromArray: dic[@"data"][@"detail"][@"article"][@"articleItems"]];
            NSLog(@"%@",dic);
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            
        }else{
          
        }
    }];
    
    
}

- (void)YloadMoreData {
    [self.tableView.footer endRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath];
        
        [cell loadNewData:self.dataList[indexPath.row]];
        return cell;
        
    }else {
        
        id item = self.dataList[indexPath.row];
        if ([item[@"type"] isEqualToString:@"IMAGE"]) {
            NewsImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"image" forIndexPath:indexPath];
            [cell loadNewData:self.dataList[indexPath.row]];
            return cell;
        }else  if ([item[@"type"] isEqualToString:@"TEXT"]){
            
            NewsTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"text" forIndexPath:indexPath];
            [cell loadNewData:self.dataList[indexPath.row]];
            return cell;
            
        }else {
            
            NewsTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"text" forIndexPath:indexPath];
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
