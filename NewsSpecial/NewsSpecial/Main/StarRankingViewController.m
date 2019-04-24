//
//  StarRankingViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarRankingViewController.h"
#import "StarRangkingCell.h"
#import "StarRankingDetailViewController.h"
@interface StarRankingViewController ()

@end

@implementation StarRankingViewController{
    int _pageNo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - 100);
    [self.tableView registerNib:[UINib nibWithNibName:@"StarRangkingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.rowHeight = 120;
    [self YreloadData];
}

- (void)YreloadData{
    _pageNo = 1;
    [YCHNetworking postStartRequestFromUrl:@"http://ywapp.hryouxi.com/yuwanapi/app/getNewRankingList" andParamter:@{@"pageNo":@(_pageNo),@"pageSize" : @"20" , @"type" : @"OPUS" , @"orderType":@"3",@"userId" : @""} returnData:^(NSData *data, NSError *error) {
      
        if (!error){
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            [self.tableView.header endRefreshing];
            [self.dataList removeAllObjects];
            [self.dataList addObjectsFromArray:dic[@"data"][@"rankingList"][@"list"]];
            [self.tableView reloadData];
        }
        
    }];
    
}
- (void)YloadMoreData{
    _pageNo += 1;
    [YCHNetworking postStartRequestFromUrl:@"http://ywapp.hryouxi.com/yuwanapi/app/getNewRankingList" andParamter:@{@"pageNo":@(_pageNo),@"pageSize" : @"20" , @"type" : @"OPUS" , @"orderType":@"3",@"userId" : @""} returnData:^(NSData *data, NSError *error) {
        if (!error){
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            [self.dataList addObjectsFromArray:dic[@"data"][@"rankingList"][@"list"]];
            [self.tableView reloadData];
        }
        [self.tableView.footer endRefreshing];
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StarRangkingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary * dic = self.dataList[indexPath.row];
    cell.title.text = dic[@"title"];
    [cell.cover ysd_setImageWithString:dic[@"cover"]];
    cell.cover.contentMode = UIViewContentModeScaleAspectFill;
    cell.doctor.text = [NSString stringWithFormat:@"%@%@",@"主演: ",dic[@"directors"]];
    cell.rank.text =  [NSString stringWithFormat:@"%@",dic[@"rank"]]  ;
    cell.hotFire.text = [NSString stringWithFormat:@"🔥 %@",dic[@"realRankingListNumber"]];
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataList.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    StarRankingDetailViewController * vc = [[StarRankingDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = true;
    NSDictionary * dic = self.dataList[indexPath.row];
    vc.contentId = dic[@"id"];
    [self.navigationController pushViewController:vc animated:true];
    
    
    
}
@end
