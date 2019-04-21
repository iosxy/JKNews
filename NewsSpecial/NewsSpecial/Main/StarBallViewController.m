//
//  StarBallViewController.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarBallViewController.h"
#import "StarBallCell.h"
@interface StarBallViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView * collectionView;



@end

@implementation StarBallViewController{
    
    int _pageNo;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;
    
    UICollectionViewFlowLayout * layoout = [[UICollectionViewFlowLayout alloc]init];
    
    layoout.minimumLineSpacing = 0;
    layoout.minimumInteritemSpacing = 10;
    layoout.itemSize = CGSizeMake(SCREEN_WIDTH/2 - 15, SCREEN_WIDTH/2 - 15);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layoout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.contentInset = UIEdgeInsetsMake(6, 10, 12, 10);
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"StarBallCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-94);
    }];
    _collectionView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        _pageNo = 1;
        [self reloadData];
    }];
    _collectionView.footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        _pageNo += 1;
        [self reloadData];
    }];
    
}

- (void)reloadData{
    
    [YCHNetworking postStartRequestFromUrl:@"http://ywapp.hryouxi.com/yuwanapi/app/listStar" andParamter:@{@"pageNo":@"1",@"pageSize" : @"20"} returnData:^(NSData *data, NSError *error) {
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        if (!error){
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
//            NSLog(dic);
            
            NSLog([NSString stringWithFormat:@"%@",dic]);
            
            
            
        }
        
        
        
        
        
    }];
    
    
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    StarBallCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  10;
}




@end
