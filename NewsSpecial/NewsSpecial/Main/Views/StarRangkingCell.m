
//
//  StarRangkingCell.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarRangkingCell.h"

@implementation StarRangkingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rank.layer.masksToBounds = YES;
    self.rank.layer.cornerRadius = 25.0 / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
