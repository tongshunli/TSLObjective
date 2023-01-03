//
//  TSLTopAlertView.m
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import "TSLTopAlertView.h"
#import "TSLUIFactory.h"

#import "TSLColorConfig.h"
#import "TSLFrameDefine.h"

#import "NSBundle+TSLExtension.h"

@implementation TSLTopAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        
        self.backgroundColor = kClearColor;
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        [kWindow addSubview:self];
        
        [self createSubviews];
        
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(recognizerHandle:)];
        recognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)createSubviews {
    [self addSubview:self.alertBottonView];
    
    [self.alertBottonView addSubview:self.alertImageView];
    
    [self.alertBottonView addSubview:self.alertTitleLabel];
}

- (void)recognizerHandle:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        [self hiddenAlertView];
    }
}

- (UIView *)alertBottonView {
    if (_alertBottonView == nil) {
        _alertBottonView = [TSLUIFactory view];
        _alertBottonView.backgroundColor = kWhiteColor;
        _alertBottonView.frame = CGRectMake(0, -kNavbarHeight, kScreenWidth, kNavbarHeight);
    }
    return _alertBottonView;
}

- (UIImageView *)alertImageView {
    if (_alertImageView == nil) {
        _alertImageView = [TSLUIFactory imageView];
        _alertImageView.frame = CGRectMake(kMargin, kNavbarHeight - 32, kMargin, kMargin);
    }
    return _alertImageView;
}

- (UILabel *)alertTitleLabel {
    if (_alertTitleLabel == nil) {
        _alertTitleLabel = [TSLUIFactory label:kFont(14) withTextColor:[UIColor blackColor]];
        _alertTitleLabel.frame = CGRectMake(50, kNavbarHeight - 37, kScreenWidth - 60.0, 30.0);
    }
    return _alertTitleLabel;
}

- (void)hiddenAlertView {
    if (self.alertViewIsHidden == NO) {
        self.alertViewIsHidden = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            kWeakSelf(weakSelf);
            
            [UIView animateWithDuration:kAnimatedDuration delay:1.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
                weakSelf.alertBottonView.frame = CGRectMake(0, -kNavbarHeight, kScreenWidth, kNavbarHeight);
            } completion:^(BOOL finished) {
                [weakSelf removeAlertView];
            }];
        });
    }
}

- (void)removeAlertView {
    self.alertTitle = @"";
    
    [self removeFromSuperview];
}

- (void)setAlertTitle:(NSString *)alertTitle {
    _alertTitle = alertTitle;
    
    self.alertTitleLabel.text = alertTitle;
}

- (void)setAlertType:(TSLTopAlertType)alertType {
    _alertType = alertType;
    
    switch (alertType) {
        case TSLTopAlertTypeSuccess:
            self.alertImageView.image = [NSBundle getBundleImageWithName:@"tips_success"];
            break;
        case TSLTopAlertTypeError:
            self.alertImageView.image = [NSBundle getBundleImageWithName:@"tips_error"];
            break;
        default:
            break;
    }
}

- (void)showAlertView {
    self.alertViewIsHidden = NO;
    
    kWeakSelf(weakSelf);
    [UIView animateWithDuration:kAnimatedDuration delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        weakSelf.alertBottonView.frame = CGRectMake(0, 0, kScreenWidth, kNavbarHeight);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf hiddenAlertView];
        });
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self) {
        return nil;
    }
    return hitView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
