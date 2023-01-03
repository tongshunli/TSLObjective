//
//  TSLUtilsHelper.m
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import "TSLUtilsHelper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation TSLUtilsHelper

+ (NSString *)formatStringWithInteger:(NSUInteger)interger {
    return [NSString stringWithFormat:@"%"MZNSI, interger];
}

+ (BOOL)getDarkMode {
    if (@available(iOS 13.0, *)) {
        return [[UITraitCollection currentTraitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark;
    }
    return NO;
}

+ (NSString *)getTimeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%0.f", interval];
}

+ (NSString *)stringToMD5:(NSString *)inputStr {
    const char *cStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), result);
    NSString *resultStr = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return [resultStr lowercaseString];
}

- (BOOL)stringIsReBlank:(NSString *)aStr {
    if (!aStr) {
        return YES;
      }
      if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
      }
      NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
      NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
      if (!trimmedStr.length) {
        return YES;
      }
      return NO;
}

@end
