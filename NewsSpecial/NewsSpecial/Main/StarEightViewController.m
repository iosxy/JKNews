//
//  StarEightViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarEightViewController.h"
#import "StarEightTableViewCell.h"
@interface StarEightViewController ()

@end

@implementation StarEightViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"StarEightTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.rowHeight = 120;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StarEightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  20;
    
}


@end
