//
//  StarBallCell.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarBallCell.h"

@implementation StarBallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentImageView.layer.masksToBounds = YES;
    self.contentImageView.layer.cornerRadius = 4.0;
}


@end
