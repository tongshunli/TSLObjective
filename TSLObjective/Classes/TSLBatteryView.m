//
//  TSLBatteryView.m
//  TSLObjective
//
//  Created by TSL on 2022/12/26.
//

#import "TSLBatteryView.h"
#import "TSLColorConfig.h"

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
    
}

- (void)batteryLevelChanged {
    
}

- (void)updateTime {
    
}

- (void)batteryStateChanged {
    
}

- (CAShapeLayer *)batteryLayer1 {
    if (_batteryLayer1 == nil) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 4.0, self.batteryWidth, 12) cornerRadius:2.0];
        
        _batteryLayer1 = [[CAShapeLayer alloc] init];
        _batteryLayer1.lineWidth = self.batteryLineWidth;
        _batteryLayer1.strokeColor = [[UIColor grayColor] CGColor];
        
    }
    return _batteryLayer1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
