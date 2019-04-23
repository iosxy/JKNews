//
//  StarRankingDetailViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/23.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarRankingDetailViewController.h"

@interface StarRankingDetailViewController ()

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation StarRankingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
    MovieDetailView * view = [[[NSBundle mainBundle]loadNibNamed:@"MovieDetailView" owner:self options:nil]lastObject];
    [self.scrollView addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_lessThanOrEqualTo(self.scrollView);
    }];
    
    
    
}


@end
