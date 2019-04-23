//
//  StarRangkingCell.h
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StarRangkingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *hotFire;
@property (weak, nonatomic) IBOutlet UILabel *doctor;


@end

NS_ASSUME_NONNULL_END
