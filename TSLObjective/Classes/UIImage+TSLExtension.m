//
//  UIImage+TSLExtension.m
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#import "UIImage+TSLExtension.h"
#import "TSLColorConfig.h"

#import <Accelerate/Accelerate.h>

@implementation UIImage (TSLExtension)

- (UIImage *)imgWithLightAlpha:(CGFloat)alpha withRadius:(CGFloat)radius withColorSaturationFactor:(CGFloat)colorSaturationFactor {
    UIColor *tintColor = kColorRGBAlpha(180, 180, 180, alpha);
    
    return [self imgBluredWithRadius:radius withTintColor:tintColor withSaturationDeltaFactor:colorSaturationFactor withMaskImage:nil];
}

- (UIImage *)imgBluredWithRadius:(CGFloat)blurRadius withTintColor:(UIColor *)tintColor withSaturationDeltaFactor:(CGFloat)saturationDeltaFactor withMaskImage:(UIImage *)maskImage {
    
    CGRect imageRect = {CGPointZero, self.size};
    
    UIImage *effectImage = self;
    
    BOOL hasBlur = (blurRadius > CGFLOAT_MIN);
    
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.0) > CGFLOAT_MIN;
    
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            
            NSInteger radius = floor(inputRadius * 3.0 * sqrt(2 * M_PI) / 4 + 0.5);
            
            if (radius % 2 != 1) {
                radius += 1;
            }
            
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (int)radius, (int)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (int)radius, (int)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (int)radius, (int)radius, 0, kvImageEdgeExtend);
        }
        
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;

            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            
            const int32_t divisor = 256;

            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);

            int16_t saturationMatrix[matrixSize];

            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            } else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        
        effectImage = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();
    }
    
    //  开启上下文 用于输出图像
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);

    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
   
    //  开始画底图
    CGContextDrawImage(outputContext, imageRect, self.CGImage);

    // 开始画模糊效果
    if (hasBlur) {
        CGContextSaveGState(outputContext);

        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // 添加颜色渲染
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
    CGContextFillRect(outputContext, imageRect);
    CGContextRestoreGState(outputContext);
    
    // 输出成品,并关闭上下文
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
