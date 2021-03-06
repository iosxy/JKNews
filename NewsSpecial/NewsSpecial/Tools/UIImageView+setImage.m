//
//  UIImageView+setImage.m
//  NewsSpecial
//
//  Created by huhu on 2019/4/21.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "UIImageView+setImage.h"

@implementation UIImageView (setImage)
- (void)ysd_setImageWithString:(NSString *)url{
    
    if ([url containsString:@".webp"]) {
        
        NSArray * strArr = [url componentsSeparatedByString:@"!"];
        
        url = [NSString stringWithFormat:@"%@%@",strArr[0],@"!200.nw"];
        
    }
    
    
    if (![url containsString:@"http"]) {
        
        url = [NSString stringWithFormat:@"%@%@",YW_URL_IMAGE,url];
        
    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
    
}
@end
