//
//  UIImage+TSLExtension.h
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//  UIImage扩展

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (TSLExtension)

- (UIImage *)imgWithLightAlpha:(CGFloat)alpha withRadius:(CGFloat)radius withColorSaturationFactor:(CGFloat)colorSaturationFactor;

- (UIImage *)imgBluredWithRadius:(CGFloat)blurRadius withTintColor:(UIColor *)tintColor withSaturationDeltaFactor:(CGFloat)saturationDeltaFactor withMaskImage:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
