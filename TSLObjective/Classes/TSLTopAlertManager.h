//
//  TSLTopAlertManager.h
//  TSLObjective
//
//  Created by TSL on 2022/12/29.
//

#import <Foundation/Foundation.h>
#import "TSLTopAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSLTopAlertManager : NSObject

+ (void)showAlertWithType:(TSLTopAlertType)type withAlertTitle:(NSString *)alertTitle;

@end

NS_ASSUME_NONNULL_END
