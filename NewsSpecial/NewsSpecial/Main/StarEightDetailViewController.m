//
//  StarEightDetailViewController.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/24.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarEightDetailViewController.h"
#import "NewsTableViewCell.h"
@interface StarEightDetailViewController ()

@end

@implementation StarEightDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"title"];
    [self.tableView registerClass:[NewsTextTableViewCell class] forCellReuseIdentifier:@"text"];
    [self.tableView registerClass:[NewsImageTableViewCell class] forCellReuseIdentifier:@"image"];
    self.tableView.estimatedRowHeight = 200;
    [self.tableView reloadData];
}
- (void)YreloadData{
    [self.tableView.header endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        
        return cell;
        
    }else if (indexPath.row == 1) {
        NewsTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"text"];
        
        return cell;
    }else {
        NewsImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"image"];
        
        return cell;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row == 1) {
        return  200;
    }else {
        return  UITableViewAutomaticDimension;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return  10;
    
    
}




@end
