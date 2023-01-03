//
//  TSLCustomButton.h
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//  自定义Button

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TSLCustomButtonIndicator) {
    TSLCustomButtonIndicatorTitleLeft   = 0, // 文字左 图片右
    TSLCustomButtonIndicatorTitleRight  = 1, // 文字右 图片左
    TSLCustomButtonIndicatorTitleTop    = 2, // 文字上 图片下
    TSLCustomButtonIndicatorTitleBottom = 3 // 文字下 图片上
};

@interface TSLCustomButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame withButtonTitle:(NSString *)buttonTitle withButtonTitleFont:(UIFont *)buttonTitleFont withButtonImageName:(NSString *)buttonImageName withButtonIndicatior:(TSLCustomButtonIndicator)buttonIndicatior;

@property (nonatomic, copy) NSString *buttonTitle;

@property (nonatomic, strong) UIFont *buttonTitleFont; // 默认字号

@property (nonatomic, copy) NSString *buttonImageName;

@property (nonatomic, assign) TSLCustomButtonIndicator buttonIndicatior;

@property (nonatomic, strong) UIView *bottonHoldView;

@property (nonatomic, strong) UILabel *buttonTitleLabel;

@property (nonatomic, strong) UIImageView *buttonImageView;

@property (nonatomic, assign) CGFloat graphicDistance; // 图文间距,默认10

//  图片尺寸
@property (nonatomic, assign) CGFloat buttonImageWidth;
@property (nonatomic, assign) CGFloat buttonImageHeight;

@property (nonatomic, strong) UIColor *buttonTintColor;

@end

NS_ASSUME_NONNULL_END
