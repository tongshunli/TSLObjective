//
//  TSLCustomButton.m
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#import "TSLCustomButton.h"
#import "TSLUIFactory.h"

#import "TSLColorConfig.h"
#import "TSLFrameDefine.h"

#import <Masonry/Masonry.h>

#import "UILabel+TSLExtension.h"

@implementation TSLCustomButton

- (instancetype)initWithFrame:(CGRect)frame withButtonTitle:(NSString *)buttonTitle withButtonTitleFont:(UIFont *)buttonTitleFont withButtonImageName:(NSString *)buttonImageName withButtonIndicatior:(TSLCustomButtonIndicator)buttonIndicatior {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonTitle = buttonTitle;
        
        if (buttonTitleFont == nil) {
            self.buttonTitleFont = kFont(12);
        } else {
            self.buttonTitleFont = buttonTitleFont;
        }
        
        self.buttonImageName = buttonImageName;
        
        self.buttonIndicatior = buttonIndicatior;
        
        self.graphicDistance = kHalfMargin;
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    [self addSubview:self.bottonHoldView];
    
    [self.bottonHoldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    
    self.buttonTitleLabel.text = self.buttonTitle;
    [self.bottonHoldView addSubview:self.buttonTitleLabel];
    
    self.buttonImageView.image = [UIImage imageNamed:self.buttonImageName];
    [self.bottonHoldView addSubview:self.buttonImageView];
}

- (UIView *)bottonHoldView {
    if (_bottonHoldView == nil) {
        _bottonHoldView = [TSLUIFactory view];
        [_bottonHoldView setUserInteractionEnabled:NO];
        _bottonHoldView.backgroundColor = kClearColor;
    }
    return _bottonHoldView;
}

- (UILabel *)buttonTitleLabel {
    if (_buttonTitleLabel == nil) {
        _buttonTitleLabel = [TSLUIFactory label:self.buttonTitleFont withTextColor:[UIColor blackColor]];
    }
    return _buttonTitleLabel;
}

- (UIImageView *)buttonImageView {
    if (_buttonImageView == nil) {
        _buttonImageView = [TSLUIFactory imageView];
    }
    return _buttonImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self refreshView];
}

- (void)refreshView {
    switch (self.buttonIndicatior) {
        case TSLCustomButtonIndicatorTitleLeft:
            [self createCustomButtonIndicatorTitleLeft];
            break;
        case TSLCustomButtonIndicatorTitleTop:
            [self createCustomButtonIndicatorTitleTop];
            break;
        case TSLCustomButtonIndicatorTitleRight:
            [self createCustomButtonIndicatorTitleRight];
            break;
        case TSLCustomButtonIndicatorTitleBottom:
            [self createCustomButtonIndicatorTitleBottom];
            break;
        default:
            break;
    }
}

#pragma mark - 文字左,图片右
- (void)createCustomButtonIndicatorTitleLeft {
    if (self.buttonTitle.length > 0 && self.buttonImageName.length > 0) {
        [self.buttonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.height.mas_equalTo(self.bottonHoldView);
            make.width.mas_equalTo(self.buttonTitleLabel.textWidth);
        }];
        
        [self.buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buttonTitleLabel.mas_right).offset(self.graphicDistance);
            make.width.mas_equalTo(self.buttonImageWidth);
            make.height.mas_equalTo(self.buttonImageHeight);
            make.right.centerY.mas_equalTo(self.bottonHoldView);
        }];
    } else if (self.buttonTitle.length > 0) {
        [self.buttonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.bottonHoldView);
            make.width.mas_equalTo(self.buttonTitleLabel.textWidth);
        }];
    } else if (self.buttonImageName.length > 0) {
        [self.buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.buttonImageWidth);
            make.height.mas_equalTo(self.buttonImageHeight);
            make.left.right.centerY.mas_equalTo(self.bottonHoldView);
        }];
    }
}

#pragma mark - 文字上,图片下
- (void)createCustomButtonIndicatorTitleTop {
    
}

#pragma mark - 文字右,图片左
- (void)createCustomButtonIndicatorTitleRight {
    
}

#pragma mark - 文字下,图片上
- (void)createCustomButtonIndicatorTitleBottom {
    
}

- (void)setButtonTintColor:(UIColor *)buttonTintColor {
    _buttonTintColor = buttonTintColor;
    
    self.buttonTitleLabel.textColor = buttonTintColor;
    
    self.buttonImageView.image = [[UIImage imageNamed:self.buttonImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.buttonImageView.tintColor = buttonTintColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
