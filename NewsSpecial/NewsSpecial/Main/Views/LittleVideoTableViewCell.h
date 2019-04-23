//
//  LittleVideoTableViewCell.h
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LittleVideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cover;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *zan;
@property (weak, nonatomic) IBOutlet UIImageView *talk;
@property (weak, nonatomic) IBOutlet UIImageView *playButton;

@end

NS_ASSUME_NONNULL_END
