//
//  StarLittleVideoViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarLittleVideoViewController.h"
#import "LittleVideoTableViewCell.h"

@interface StarLittleVideoViewController ()

@end

@implementation StarLittleVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerNib:[UINib nibWithNibName:@"LittleVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.rowHeight = 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LittleVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  20;
    
}

@end
