//
//  TSLTopAlertView.h
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TSLTopAlertType) {
    TSLTopAlertTypeSuccess = 0,
    TSLTopAlertTypeError = 1
};

@interface TSLTopAlertView : UIView

@property (nonatomic, strong) UIView *alertBottonView;

@property (nonatomic, strong) UIImageView *alertImageView;

@property (nonatomic, strong) UILabel *alertTitleLabel;

@property (nonatomic, assign) bool alertViewIsHidden;

@property (nonatomic, copy) NSString *alertTitle;

@property (nonatomic, assign) TSLTopAlertType alertType;

- (void)hiddenAlertView;

- (void)showAlertView;

@end

NS_ASSUME_NONNULL_END
