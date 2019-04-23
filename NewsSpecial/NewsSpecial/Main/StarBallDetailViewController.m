//
//  StarBallDetailViewController.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/23.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarBallDetailViewController.h"

@interface StarBallDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation StarBallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"星球";
    
    YuwanCardHeaderView * view = [[[NSBundle mainBundle]loadNibNamed:@"YuwanCardHeaderView" owner:self options:nil]lastObject];
    [self.scrollView addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_lessThanOrEqualTo(self.scrollView);
    }];
    
    
    
}




@end
