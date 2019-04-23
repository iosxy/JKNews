
//
//  YBaseViewController.m
//  weiliao
//
//  Created by 游成虎 on 2019/4/17.
//  Copyright © 2019年 游成虎. All rights reserved.
//

#import "YBaseViewController.h"



@interface YBaseViewController ()

@end

@implementation YBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}
- (void)createTableView {
    self.dataList = [NSMutableArray new];
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(YreloadData)];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(YloadMoreData)];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-64);
    }];
}

- (void)YreloadData{
    
    
    
}
- (void)YloadMoreData{
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}



@end
