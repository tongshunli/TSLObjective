//
//  TSLFrameDefine.h
//  Pods
//
//  Created by TSL on 2022/12/29.
//

#ifndef TSLFrameDefine_h
#define TSLFrameDefine_h

#import "TSLSystemConfig.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kMargin 20.0

#define kMoreHalfMargin 15.0

#define kHalfMargin 10.0

#define kQuarterMargin 5.0

#define kLineHeight 0.5

#define kStatusBarHeight kIsIphoneX ? 44.0 : 20.0

#define kNavbarHeight kIsIphoneX ? 88.0 : 64.0

#define kTabbarHeight kIsIphoneX ? 83.0 : 49.0

#define kAnimatedDuration 0.4 // 动画时长

#define kFont(fontSize) [UIFont systemFontOfSize:fontSize]

#define kBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]

#define kGeometricHeight(width, proportionWidth, proportionHeight) floor(width * proportionHeight / proportionWidth)

#define kGeometricWidth(height, proportionWidth, proportionHeight) floor(height * proportionWidth / proportionHeight)

#endif /* TSLFrameDefine_h */
