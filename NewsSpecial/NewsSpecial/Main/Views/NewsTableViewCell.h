//
//  NewsTableViewCell.h
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/24.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell
- (void)loadData:(NSDictionary *)item;
@end
@interface NewsTextTableViewCell : UITableViewCell
- (void)loadData:(NSString *)item;
@end
@interface NewsImageTableViewCell : UITableViewCell
- (void)loadData:(NSDictionary *)item;
@end

NS_ASSUME_NONNULL_END
