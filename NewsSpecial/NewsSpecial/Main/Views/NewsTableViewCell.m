//
//  NewsTableViewCell.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/24.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell{
    
    UILabel * _title;
    UILabel * _time;
    UILabel * _from;
    
    
    
}

- (instancetype)initWithFrame:(CGRect)frame{
   
    if (self =  [super initWithFrame:frame]) {
        
        _title = [UILabel new];
        _title.text = @"标题";
        _title.numberOfLines = 0;
        _time = [UILabel new];
        _time.text = @"时间";
        _time.font = [UIFont systemFontOfSize:12];
        _time.textColor = [UIColor grayColor];
        
        _from = [UILabel new];
        _from.text = @"官方";
        _from.font = [UIFont systemFontOfSize:12];
        _from.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_time];
        [self.contentView addSubview:_from];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12));
            make.right.equalTo(self.contentView).offset(-12);
            
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.contentView).offset(-12);
            make.bottom.equalTo(self.contentView).offset(-12);
        }];
        [_from mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_time.mas_left).offset(-12);
            make.bottom.equalTo(self.contentView).offset(-12);
        }];
        
    }
 
    return self;
}

@end
@implementation NewsTextTableViewCell{
    
    UILabel * _content;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =  [super initWithFrame:frame]) {
        
        
        _content = [UILabel new];
        _content.font = [UIFont systemFontOfSize:14];
        _content.text = @"文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章章内容文章内容文章内容文章内容文章内容文章内容文章内容文章章内容文章内容文章内容文章内容文章内容文章内容文章内容文章章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容";
        _content.numberOfLines = 0;
        [self.contentView addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12));
            make.right.equalTo(self.contentView).offset(-12);
            make.bottom.lessThanOrEqualTo(self.contentView);
        }];
        
    }
    
    
    return self;
}

@end

@implementation NewsImageTableViewCell{
    
    UIImageView * _contentImaageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]) {
        
        _contentImaageView = [UIImageView new];
        _contentImaageView.image = [UIImage imageNamed:@"娱乐1"];
        _contentImaageView.contentMode = UIViewContentModeCenter;
        
        [self.contentView addSubview:_contentImaageView];
        [_contentImaageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self.contentView).offset(-12);
            
        }];
        
        
    }
    
    
    return self;
    
}

@end

