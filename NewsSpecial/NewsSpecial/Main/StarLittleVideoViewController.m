//
//  StarLittleVideoViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarLittleVideoViewController.h"
#import "LittleVideoTableViewCell.h"
#import <AVKit/AVKit.h>
#define VIDEO_URL @"http://api.app.happyjuzi.com/video/category?accesstoken=5fc865056742c82430db621de55b1320&brand=Apple&carrier=2&id=247&idfa=AD40CFA7-85B0-4ECB-A823-313C5F85C325&model=iPhone7Plus&net=wifi&page=%d&pf=ios&res=414x736&size=20&system=12.1.4&uid=4363595144352692&ver=4.1"
#define VIDEO_DETAIL @"http://api.app.happyjuzi.com/article/detail?accesstoken=5fc865056742c82430db621de55b1320&brand=Apple&carrier=2&id=%@&idfa=AD40CFA7-85B0-4ECB-A823-313C5F85C325&model=iPhone7Plus&net=wifi&pf=ios&res=414x736&system=12.1.4&uid=4363595144352692&ver=4.1"

@interface StarLittleVideoViewController ()

@end

@implementation StarLittleVideoViewController {
    
    int _index;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerNib:[UINib nibWithNibName:@"LittleVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.rowHeight = 300;
    [self YreloadData];
}

- (void)YreloadData{
    _index = 1;
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:VIDEO_URL,_index] andParamter:@{} returnData:^(NSData *data, NSError *error) {
        
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
    
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:VIDEO_URL,_index] andParamter:@{} returnData:^(NSData *data, NSError *error) {
        
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
    
    LittleVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary * dic = self.dataList[indexPath.row];
    
    cell.title.text = dic[@"title"];

    [cell.cover ysd_setImageWithString:dic[@"pic"]];
    
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataList.count;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
    NSDictionary * dic = self.dataList[indexPath.row];
    
    
    


    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:VIDEO_DETAIL,dic[@"id"]] andParamter:@{} returnData:^(NSData *data, NSError *error) {

    

        if (!error) {

            NSDictionary * newdic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];

            NSLog(@"%@",dic);
            NSString * url = newdic[@"data"][@"info"][@"video"][@"url"];
            
            AVPlayerViewController * vc = [[AVPlayerViewController alloc]init];
            vc.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:url]];
            
            [vc.player play];
            [self.navigationController presentViewController:vc animated:true completion:^{
                
            }];
           

        }

    }];

    
    
    
    
    
    
    
    

    
    
    
    
}
@end
