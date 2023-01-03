//
//  TSLUtilsHelper.h
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#if __LP64__
#define MZNSI @"ld"
#define MZNSU @"lu"
#else
#define MZNSI @"d"
#define MZNSU @"u"
#endif //__LP64__

@interface TSLUtilsHelper : NSObject

+ (NSString *)formatStringWithInteger:(NSUInteger)interger;

+ (BOOL)getDarkMode; // 暗黑模式

+ (NSString *)getTimeStamp;

+ (NSString *)stringToMD5:(NSString *)inputStr;

- (BOOL)stringIsReBlank:(NSString *)aStr;

@end

NS_ASSUME_NONNULL_END
