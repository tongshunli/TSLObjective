//
//  UIColor+TSLExtension.h
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//  UIColor扩展

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TSLGradientChangeDirection) {
    TSLGradientChangeDirectionLevel                 = 0, // 水平方向上渐变
    TSLGradientChangeDirectionVertical              = 1, // 竖直方向上渐变
    TSLGradientChangeDirectionUpwardDiagonalLine    = 2, // 向下对角线渐变
    TSLGradientChangeDirectionDownDiagonalLine      = 3 // 向上对角线渐变
};

@interface UIColor (TSLExtension)

+ (UIColor *)colorGradientChangeWithSize:(CGSize)size withDirection:(TSLGradientChangeDirection)direction withStartColor:(UIColor *)startColor withEndColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
