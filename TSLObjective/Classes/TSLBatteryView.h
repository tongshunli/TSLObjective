//
//  TSLBatteryView.h
//  TSLObjective
//
//  Created by TSL on 2022/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TSLBatteryStateColor)
{
    TSLBatteryStateColorNormal = 0, // 正常状态
    TSLBatteryStateColorCharging = 1, // 充电状态
    TSLBatteryStateColorWarning = 2 // 电量不足
};

@interface TSLBatteryView : UIView

@property (nonatomic, strong) CAShapeLayer *batteryLayer1;

@property (nonatomic, strong) CAShapeLayer *batteryLayer2;

@property (nonatomic, assign) CGFloat batteryWidth; // 电池宽度

@property (nonatomic, assign) CGFloat batteryLineWidth; // 电池线宽

@end

NS_ASSUME_NONNULL_END
