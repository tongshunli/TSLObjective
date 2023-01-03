//
//  TSLBatteryView.m
//  TSLObjective
//
//  Created by TSL on 2022/12/26.
//

#import "TSLBatteryView.h"
#import "TSLUIFactory.h"
#import "TSLUtilsHelper.h"

#import "TSLColorConfig.h"
#import "TSLFrameDefine.h"
#import "TSLSystemConfig.h"

@implementation TSLBatteryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initialize];
        [self createSubviews];
        [self batteryLevelChanged];
        [self updateTime];
    }
    return self;
}

- (void)initialize {
    self.batteryWidth = 25.0;
    
    self.batteryLineWidth = 1.0;
    
    UIDevice *device = [UIDevice currentDevice];
    [device setBatteryMonitoringEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryLevelChanged) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryStateChanged) name:UIDeviceBatteryStateDidChangeNotification object:nil];
}

- (void)createSubviews {
    [self.layer addSublayer:self.batteryLayer1];
    
    [self.layer addSublayer:self.batteryLayer2];
    
    [self addSubview:self.batteryView];
    
    [self addSubview:self.batteryLabel];
    
    kWeakSelf(weakSelf);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf updateTime];
    }];
}

#pragma mark - 电量状态发生变化
- (void)batteryLevelChanged {
    UIDevice *device = [UIDevice currentDevice];
    [device setBatteryMonitoringEnabled:YES];

    CGFloat batteryLevel = device.batteryLevel * 100;
    
    if (batteryLevel < 0) {
        batteryLevel = 0;
    } else if (batteryLevel > 100) {
        batteryLevel = 100;
    }
    
    if (batteryLevel <= 10) {
        [self changeBatteryState:TSLBatteryStateColorWarning];
    } else {
        [self changeBatteryState:TSLBatteryStateColorNormal];
    }
    
    CGRect frame = self.batteryView.frame;
    frame.size.width = batteryLevel * (self.batteryWidth - self.batteryLineWidth * 2) / 100;
    self.batteryView.frame = frame;
}

#pragma mark - 更新当前时间
- (void)updateTime {
    NSDate *now = [[NSDate alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:now];
    
    NSInteger hour = [dateComponent hour];
    
    NSInteger minute = [dateComponent minute];
    
    if (hour < 10 && minute < 10) {
        self.batteryLabel.text = [NSString stringWithFormat:@"0%@ : 0%@", [TSLUtilsHelper formatStringWithInteger:hour], [TSLUtilsHelper formatStringWithInteger:minute]];
    } else if (hour < 10) {
        self.batteryLabel.text = [NSString stringWithFormat:@"0%@ : %@", [TSLUtilsHelper formatStringWithInteger:hour], [TSLUtilsHelper formatStringWithInteger:minute]];
    } else if (minute < 10) {
        self.batteryLabel.text = [NSString stringWithFormat:@"%@ : 0%@", [TSLUtilsHelper formatStringWithInteger:hour], [TSLUtilsHelper formatStringWithInteger:minute]];
    } else {
        self.batteryLabel.text = [NSString stringWithFormat:@"%@ : %@", [TSLUtilsHelper formatStringWithInteger:hour], [TSLUtilsHelper formatStringWithInteger:minute]];
    }
}

#pragma mark - 电池状态发生变化
- (void)batteryStateChanged {
    switch ([UIDevice currentDevice].batteryState) {
        case UIDeviceBatteryStateUnplugged:
            [self changeBatteryState:TSLBatteryStateColorNormal];
            break;
        case UIDeviceBatteryStateCharging:
            [self changeBatteryState:TSLBatteryStateColorCharging];
            break;
        case UIDeviceBatteryStateFull:
            [self changeBatteryState:TSLBatteryStateColorCharging];
            break;
        default:
            [self changeBatteryState:TSLBatteryStateColorNormal];
            break;
    }
}

- (CAShapeLayer *)batteryLayer1 {
    if (_batteryLayer1 == nil) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 4.0, self.batteryWidth, 12) cornerRadius:2.0];
        
        _batteryLayer1 = [[CAShapeLayer alloc] init];
        _batteryLayer1.lineWidth = self.batteryLineWidth;
        _batteryLayer1.strokeColor = [UIColor grayColor].CGColor;
        _batteryLayer1.fillColor = kClearColor.CGColor;
        _batteryLayer1.path = path.CGPath;
    }
    return _batteryLayer1;
}

- (CAShapeLayer *)batteryLayer2 {
    if (_batteryLayer2 == nil) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.batteryWidth + 1.0, 8.0)];
        [path addLineToPoint:CGPointMake(self.batteryWidth + 1.0, 12.0)];
        
        _batteryLayer2 = [[CAShapeLayer alloc] init];
        _batteryLayer2.lineWidth = 2.0;
        _batteryLayer2.strokeColor = [UIColor grayColor].CGColor;
        _batteryLayer2.fillColor = kClearColor.CGColor;
        _batteryLayer2.path = path.CGPath;
    }
    return _batteryLayer2;
}

- (UIView *)batteryView {
    if (_batteryView == nil) {
        _batteryView = [TSLUIFactory view];
        _batteryView.layer.cornerRadius = 1.0;
        _batteryView.frame = CGRectMake(1, 4.0 + self.batteryLineWidth, 0, 12.0 - self.batteryLineWidth * 2);
    }
    return _batteryView;
}

- (UILabel *)batteryLabel {
    if (_batteryLabel == nil) {
        _batteryLabel = [TSLUIFactory label:kFont(10) withTextColor:UIColor.grayColor];
        _batteryLabel.frame = CGRectMake(self.batteryWidth + 5.0, 4.0, 80.0, 12.0);
    }
    return _batteryLabel;
}

- (void)changeBatteryState:(TSLBatteryStateColor)batteryState {
    switch (batteryState) {
        case TSLBatteryStateColorCharging:
            self.batteryView.backgroundColor = kColorRGB(75, 216, 102);
            break;
        case TSLBatteryStateColorWarning:
            self.batteryView.backgroundColor = kColorRGB(252, 62, 46);
            break;
        default:
            self.batteryView.backgroundColor = kColorRGB(131, 131, 131);
            break;
    }
}

- (void)setBatteryTintColor:(UIColor *)batteryTintColor {
    _batteryTintColor = batteryTintColor;
    
    self.batteryLayer1.strokeColor = batteryTintColor.CGColor;
    
    self.batteryLayer2.strokeColor = batteryTintColor.CGColor;
    
    self.batteryLabel.textColor = batteryTintColor;
    
    if ([UIDevice currentDevice].batteryState == UIDeviceBatteryStateCharging || [UIDevice currentDevice].batteryState == UIDeviceBatteryStateFull) {
        [self changeBatteryState:TSLBatteryStateColorCharging];
    }
}

- (void)dealloc {
    [self.timer invalidate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
