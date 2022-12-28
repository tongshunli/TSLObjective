//
//  TSLCustomButton.m
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#import "TSLCustomButton.h"
#import "TSLUIFactory.h"

#import "TSLColorConfig.h"

@implementation TSLCustomButton

- (instancetype)initWithFrame:(CGRect)frame withButtonTitle:(NSString *)buttonTitle withButtonTitleFont:(UIFont *)buttonTitleFont withButtonImageName:(NSString *)buttonImageName withButtonIndicatior:(TSLCustomButtonIndicator)buttonIndicatior {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonTitle = buttonTitle;
        
        self.buttonTitleFont = buttonTitleFont;
        
        self.buttonImageName = buttonImageName;
        
        self.buttonIndicatior = buttonIndicatior;
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    [self addSubview:self.bottonHoldView];
    
    
}

- (UIView *)bottonHoldView {
    if (_bottonHoldView == nil) {
        _bottonHoldView = [TSLUIFactory view];
        [_bottonHoldView setUserInteractionEnabled:NO];
        _bottonHoldView.backgroundColor = kClearColor;
    }
    return _bottonHoldView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
