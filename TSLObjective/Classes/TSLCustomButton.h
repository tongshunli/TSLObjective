//
//  TSLCustomButton.h
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TSLCustomButtonIndicator) {
    TSLCustomButtonIndicatorTitleLeft = 0, // 文字左 图片右
    TSLCustomButtonIndicatorTitleRight = 1, // 文字右 图片左
    TSLCustomButtonIndicatorTitleTop = 2, // 文字上 图片下
    TSLCustomButtonIndicatorTitleBottom = 3 // 文字下 图片上
};

@interface TSLCustomButton : UIButton

@property (nonatomic, copy) NSString *buttonTitle;

@property (nonatomic, strong) UIFont *buttonTitleFont;

@property (nonatomic, copy) NSString *buttonImageName;

@property (nonatomic, assign) TSLCustomButtonIndicator buttonIndicatior;

@property (nonatomic, strong) UIView *bottonHoldView;

@end

NS_ASSUME_NONNULL_END
