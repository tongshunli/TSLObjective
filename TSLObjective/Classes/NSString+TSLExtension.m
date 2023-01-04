//
//  NSString+TSLExtension.m
//  TSLObjective
//
//  Created by TSL on 2023/1/4.
//

#import "NSString+TSLExtension.h"

@implementation NSString (TSLExtension)

#pragma mark - 处理URL中的中文
- (NSString *)sinicizationUrl {
    BOOL status = [self containChinese];

    if (status) {
        NSString *t_url = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return t_url;
    }
    return self;
}

- (BOOL)containChinese {
    for (int i = 0; i < [self length]; i++) {
        unichar t_char = [self characterAtIndex:i];
        if (t_char >= 0x4E00 && t_char <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

@end
