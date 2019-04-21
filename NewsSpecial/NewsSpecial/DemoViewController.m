//
//  DemoViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@property (nonatomic ,strong) UICollectionView * collectionView;




@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UICollectionViewFlowLayout * layoout = [[UICollectionViewFlowLayout alloc]init];
    
    layoout.minimumLineSpacing = 10;
    layoout.minimumInteritemSpacing = 10;
    layoout.itemSize = CGSizeMake(0, 0);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layoout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"StarBallCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}


@end
