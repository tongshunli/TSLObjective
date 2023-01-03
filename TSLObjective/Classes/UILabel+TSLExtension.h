//
//  UILabel+TSLExtension.h
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (TSLExtension)

@property (nonatomic, readonly) CGFloat textWidth;

@property (nonatomic, readonly) CGFloat textHeight;

@property (nonatomic, readonly) CGFloat attributedTextWidth;

@property (nonatomic, readonly) CGFloat attributedTextHeight;

@end

NS_ASSUME_NONNULL_END
