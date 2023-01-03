//
//  NSBundle+TSLExtension.h
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//  NSBundle扩展

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (TSLExtension)

+ (UIImage *)getBundleImageWithName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
