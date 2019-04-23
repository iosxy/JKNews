//
//  FirstViewController.m
//  weiliao
//
//  Created by 游成虎 on 16/11/2.
//  Copyright © 2016年 游成虎. All rights reserved.
//


#import "FirstViewController.h"
#import "NinaPagerView.h"
#import "MineViewController.h"
#import "StarBallViewController.h"
#import "StarRankingViewController.h"
#import "StarEightViewController.h"
#import "StarLittleVideoViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FirstViewController ()<NinaPagerViewDelegate>

@property (nonatomic,strong) NinaPagerView *ninaPagerView;
@property (nonatomic,strong) NSMutableArray *channelArr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configData];
}
- (void)configUI
{
    [self.ninaPagerView removeFromSuperview];
    self.ninaPagerView = nil;
    [self.view addSubview:[self ninaPagerView]];
}
- (void)configData
{
    [self configUI];

}

#pragma mark - LazyLoad
- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        NSArray *vcsArray = [self ninaDetailVCsArray];
        CGRect pagerRect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithVCs:vcsArray];
        _ninaPagerView.ninaPagerStyles = NinaPagerStyleSlideBlock;
        _ninaPagerView.sliderBlockColor = PrinkColor;
        _ninaPagerView.sliderHeight = 33;
        _ninaPagerView.slideBlockCornerRadius = 2;
        _ninaPagerView.delegate = self;
        _ninaPagerView.selectTitleColor = [UIColor whiteColor];
        _ninaPagerView.unSelectTitleColor = [UIColor lightGrayColor];
        
        _ninaPagerView.titleFont = 14;
        _ninaPagerView.titleScale = 1.0;
        _ninaPagerView.underLineHidden = YES;
        _ninaPagerView.delegate = self;
    }
    return _ninaPagerView;
}
- (NSArray *)ninaTitleArray {

    return @[@"星球",
             @"星榜",
             @"星八卦",
             @"小视频"
             ];
}
- (NSMutableArray *)channelArr
{
    if (_channelArr == nil) {
        _channelArr = [NSMutableArray array];
    }
    return _channelArr;
}
- (NSArray *)ninaDetailVCsArray {
    NSMutableArray * viewControllers = [NSMutableArray array];
    
    
    StarBallViewController * vc1 = [[StarBallViewController alloc]init];
    StarRankingViewController * vc2 = [[StarRankingViewController alloc]init];

    StarEightViewController * vc3 = [[StarEightViewController alloc]init];

    StarLittleVideoViewController * vc4 = [[StarLittleVideoViewController alloc]init];


    [viewControllers addObject:vc1];
    [viewControllers addObject:vc2];
    [viewControllers addObject:vc3];
    [viewControllers addObject:vc4];
    
    
    
    return  viewControllers;
}

- (void)ninaCurrentPageIndex:(NSInteger)currentPage currentObject:(id)currentObject lastObject:(id)lastObject
{

    
}


@end
