//
//  TSLTopAlertManager.m
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import "TSLTopAlertManager.h"

@implementation TSLTopAlertManager

static TSLTopAlertView *_topAlertView = nil;

+ (void)showAlertWithType:(TSLTopAlertType)type withAlertTitle:(NSString *)alertTitle {

    if (alertTitle.length == 0) {
        return;
    }
    
    if ([_topAlertView.alertTitle isEqualToString:alertTitle]) {
        return;
    }
    
    [_topAlertView hiddenAlertView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _topAlertView = [[TSLTopAlertView alloc] init];
        _topAlertView.alertTitle = alertTitle;
        _topAlertView.alertType = type;
        [_topAlertView showAlertView];
    });
}

@end
