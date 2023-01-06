//
//  TSLViewHelper.m
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import "TSLViewHelper.h"
#import "TSLSystemConfig.h"

@implementation TSLViewHelper

+ (UIWindow *)getWindow {
    if (@available(iOS 13.0, *)) {
        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        
        UIWindowScene *windowScene = (UIWindowScene *)array.firstObject;
        
        UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
        
        if (mainWindow) {
            return mainWindow;
        } else {
            return [[[UIApplication sharedApplication] windows] lastObject];
        }
    } else {
        return [[UIApplication sharedApplication] keyWindow];
    }
}

#pragma mark - 获取RootController
+ (UIViewController *)getWindowRootController {
    UIViewController *rootController = [TSLViewHelper getWindow].rootViewController;
    
    while (rootController.presentedViewController != nil) {
        return rootController.presentedViewController;
    }
    return rootController;
}

#pragma mark - 获取当前Controller
+ (UIViewController *)getCurrentViewController {
    UIViewController *result = [TSLViewHelper getWindow].rootViewController;
    
    while (result.presentedViewController != nil) {
        return result.presentedViewController;
    }
    
    if ([result isKindOfClass:UITabBarController.class]) {
        return [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:UINavigationController.class]) {
        return [(UINavigationController *)result visibleViewController];
    }
    
    return result;
}

#pragma mark - 计算字符串高
+ (CGFloat)getStringHeight:(NSString *)string withMaxWidth:(CGFloat)maxWidth withContentFont:(UIFont *)font withLineHeight:(CGFloat)lineHeight {
    if (string.length == 0) {
        return 0.0;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineHeight;
    
    return floor([string boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle} context:nil].size.height) + 1.0;
}

#pragma mark - 计算字符串宽
+ (CGFloat)getStringWidth:(NSString *)string withContentFont:(UIFont *)font {
    if (string.length == 0) {
        return 0.0;
    }
    
    return floor([string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width) + 1.0;
}

#pragma mark - 设置边角圆弧
+ (void)setCornerWithLeftTopCorner:(CGFloat)leftTop withRightTop:(CGFloat)rightTop withBottemLeft:(CGFloat)bottemLeft withBottemRight:(CGFloat)bottemRight withView:(UIView *)view withFrame:(CGRect)frame {
    CGFloat width = frame.size.width;
    
    CGFloat height = frame.size.height;
    
    UIBezierPath *maskPath = [[UIBezierPath alloc] init];
    maskPath.lineWidth = 1.0;
    maskPath.lineCapStyle = kCGLineCapRound;
    maskPath.lineJoinStyle = kCGLineJoinRound;
    [maskPath moveToPoint:CGPointMake(bottemRight, height)];
    //  左下角
    
    [maskPath addLineToPoint:CGPointMake(width - bottemRight, height)];
    [maskPath addQuadCurveToPoint:CGPointMake(width, height - bottemRight) controlPoint:CGPointMake(width, height)];

    //  右下角
    [maskPath addLineToPoint:CGPointMake(width, height)];
    [maskPath addQuadCurveToPoint:CGPointMake(width - rightTop, 0) controlPoint:CGPointMake(width, 0)];

    //  右上角
    [maskPath addLineToPoint:CGPointMake(leftTop, 0)];
    [maskPath addQuadCurveToPoint:CGPointMake(0, leftTop) controlPoint:CGPointMake(0, 0)];

    //  左上角
    [maskPath addLineToPoint:CGPointMake(0, height - bottemLeft)];
    [maskPath addQuadCurveToPoint:CGPointMake(bottemLeft, height) controlPoint:CGPointMake(0, height)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark - 将图片转换成字符串
+ (NSString *)getBase64StringWithImageData:(NSData *)imageData {
    if (imageData.length == 0) {
        return @"";
    }
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (image == nil) {
        return @"";
    }
    
    UIImage *fixImage = [self fixOrientation:image];
    
    return [self imageToStrin:[self imageWithImage:fixImage]];
}

+ (UIImage *)fixOrientation:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) {
        return image;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.height, image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

#pragma mark - 绘制一张全新的图片
+ (UIImage *)imageWithImage:(UIImage *)image {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width, image.size.height));
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 图片信息转字符串
+ (NSString *)imageToStrin:(UIImage *)image {
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    imageData = UIImageJPEGRepresentation(image, 0.7f);
    mimeType = @"image/jpeg";
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
}

#pragma mark - 暗黑状态
+ (BOOL)getDarkMode {
    if (@available(iOS 13.0, *)) {
        return [[UITraitCollection currentTraitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark;
    }
    return NO;
}

#pragma mark - 白色导航栏
+ (void)setStateBarLightStyle {
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 黑色导航栏
+ (void)setStateBarDefaultStyle {
    if ([self getDarkMode]) {
        [self setStateBarLightStyle];
    } else {
        [UIApplication sharedApplication].statusBarHidden = NO;
        if (@available(iOS 13.0, *)) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
