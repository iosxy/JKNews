//
//  StarEightViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarEightViewController.h"
#import "StarEightTableViewCell.h"
#import "StarEightDetailViewController.h"
#define  ARTICLE_LIST @"http://api.app.happyjuzi.com/article/list/home?accesstoken=5fc865056742c82430db621de55b1320&brand=Apple&carrier=2&id=0&idfa=AD40CFA7-85B0-4ECB-A823-313C5F85C325&model=iPhone7Plus&net=wifi&page=%d&pf=ios&res=414x736&size=20&system=12.1.4&uid=4363595144352692&ver=4.1"

@interface StarEightViewController ()

@end

@implementation StarEightViewController {
    
    int _index;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"StarEightTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.rowHeight = 120;
    
    [self YreloadData];
}
- (void)YreloadData{
    _index = 1;
    
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:ARTICLE_LIST,_index] andParamter:@{} returnData:^(NSData *data, NSError *error) {
        
        [self.tableView.header endRefreshing];
        
        if (!error) {
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            NSLog(@"%@",dic);
            [self.dataList removeAllObjects];
            [self.dataList addObjectsFromArray:dic[@"data"][@"list"]];
            
            [self.tableView reloadData];
            
        }
        
    }];
  
    
}
- (void)YloadMoreData{
    
    _index += 1;
    
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:ARTICLE_LIST,_index] andParamter:@{} returnData:^(NSData *data, NSError *error) {
        
        [self.tableView.footer endRefreshing];
        
        if (!error) {
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            NSLog(@"%@",dic);
            
            [self.dataList addObjectsFromArray:dic[@"data"][@"list"]];
            
            [self.tableView reloadData];
            
        }
        
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StarEightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary * dic = self.dataList[indexPath.row];
    
    cell.title.text  = dic[@"title"];
    [cell.cover ysd_setImageWithString:dic[@"pic"]];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    StarEightDetailViewController * vc = [[StarEightDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataList.count;
    
}


@end
