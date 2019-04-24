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
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *hot;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UILabel *infoLeft;
@property (weak, nonatomic) IBOutlet UILabel *infoRight;
@property (weak, nonatomic) IBOutlet UILabel *soccer;

@end

@implementation StarBallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"星球";
    
 
    [self reloadData];
    
}

-(void)reloadData{
    
    
    
}


@end
