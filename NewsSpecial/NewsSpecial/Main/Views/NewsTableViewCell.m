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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _title = [UILabel new];
        _title.text = @"标题";
        _title.numberOfLines = 0;
        _title.textAlignment = NSTextAlignmentCenter;
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
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12));
            make.right.equalTo(self.contentView).offset(-12);
            make.top.equalTo(@(12));
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
- (void)loadData:(NSDictionary *)item {
    _title.text = item[@"title"];
    _time.text = item[@"publish_time"];
}
- (void)loadNewData:(NSDictionary *)item{
    
    _title.text = item[@"title"];
    _from.text = @"官方";
 //   _from.text = item[@"from"];
//    if ([_from.text isEqualToString:@"娱丸官方"]) {
//        _from.text = @"官方";
//    }
    _time.text = [self getTimeFromTimestamp:[item[@"time"] doubleValue]];

}
- (NSString *)getTimeFromTimestamp:(double)time{
    time = time / 1000;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}
@end
@implementation NewsTextTableViewCell{
    
    UILabel * _content;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _content = [UILabel new];
        _content.font = [UIFont systemFontOfSize:14];
        _content.text = @"";
        _content.numberOfLines = 0;
        [self.contentView addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12));
            make.right.equalTo(self.contentView).offset(-12);
            make.top.equalTo(@(6));
            make.bottom.lessThanOrEqualTo(self.contentView);
        }];
        
    }
    
    
    return self;
}
- (void)loadData:(NSString *)item
{
    if ([item containsString:@"IMG"]) {
        item = @"";
    }
    if ([item containsString:@"<p>"]) {
        NSMutableString * newItem = [[NSMutableString alloc]initWithString:item];
        
        item = [newItem stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    }
    if ([item containsString:@"</p>"]) {
        NSMutableString * newItem = [[NSMutableString alloc]initWithString:item];
        
        item = [newItem stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    }
    if ([item containsString:@"<p style=\"text-align: center;\">"]) {
        NSMutableString * newItem = [[NSMutableString alloc]initWithString:item];
        
        item = [newItem stringByReplacingOccurrencesOfString:@"<p style=\"text-align: center;\">" withString:@""];
    }
    _content.text = item;
    
}
- (void)loadNewData:(NSDictionary *)item{
    _content.text = item[@"text"];
}
@end

@implementation NewsImageTableViewCell{
    
    UIImageView * _contentImaageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _contentImaageView = [UIImageView new];
        _contentImaageView.image = [UIImage imageNamed:@"logo"];
        _contentImaageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_contentImaageView];
        [_contentImaageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@(12));
            make.top.equalTo(@(6));
            make.right.bottom.equalTo(self.contentView).offset(-6);
            make.height.mas_lessThanOrEqualTo(300);
        }];
        
    }
    
    
    return self;
    
}
- (void)loadData:(NSDictionary *)item {
    [_contentImaageView ysd_setImageWithString:item[@"src"]];
}
- (void)loadNewData:(NSDictionary *)item{
    [_contentImaageView ysd_setImageWithString:item[@"image"][@"url"]];
    
}
@end

