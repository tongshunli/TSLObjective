//
//  NSBundle+TSLExtension.m
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#import "NSBundle+TSLExtension.h"

@implementation NSBundle (TSLExtension)

+ (UIImage *)getBundleImageWithName:(NSString *)imageName {
    NSBundle *currentBundle = [NSBundle mainBundle];
    
    NSString *bundlePath = [currentBundle pathForResource:@"TSLObjective" ofType:@"bundle"];
    
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    
    if (resource_bundle == nil) {
        return nil;
    }
    
    return [UIImage imageNamed:imageName inBundle:resource_bundle compatibleWithTraitCollection:nil];
}

@end
