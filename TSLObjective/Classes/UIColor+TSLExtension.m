//
//  UIColor+TSLExtension.m
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#import "UIColor+TSLExtension.h"

@implementation UIColor (TSLExtension)

+ (UIColor *)colorGradientChangeWithSize:(CGSize)size withDirection:(TSLGradientChangeDirection)direction withStartColor:(UIColor *)startColor withEndColor:(UIColor *)endColor {

    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return [UIColor clearColor];
    }
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    
    if (direction == TSLGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    
    switch (direction) {
        case TSLGradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case TSLGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case TSLGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case TSLGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    
    UIGraphicsBeginImageContext(size);
    
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
