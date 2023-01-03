//
//  TSLViewHelper.h
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSLViewHelper : UIView

+ (UIWindow *)getWindow;

+ (UIViewController *)getWindowRootController;

+ (UIViewController *)getCurrentViewController;

+ (CGFloat)getStringHeight:(NSString *)string withMaxWidth:(CGFloat)maxWidth withContentFont:(UIFont *)font withLineHeight:(CGFloat)lineHeight;

+ (CGFloat)getStringWidth:(NSString *)string withContentFont:(UIFont *)font;

+ (void)setCornerWithLeftTopCorner:(CGFloat)leftTop withRightTop:(CGFloat)rightTop withBottemLeft:(CGFloat)bottemLeft withBottemRight:(CGFloat)bottemRight withView:(UIView *)view withFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
