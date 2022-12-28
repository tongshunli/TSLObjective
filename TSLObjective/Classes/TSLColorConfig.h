//
//  TSLColorConfig.h
//  TSLObjective
//
//  Created by TSL on 2022/12/28.
//

#ifndef TSLColorConfig_h
#define TSLColorConfig_h

#define kColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kColorRGBAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define kColorWithRGB(rgbValue) kColorWithRGBA(rgbValue, a)

#define kColorWithRGBA(rgbValue, a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]  //十六进制颜色(不带透明度)

#define kClearColor [UIColor clearColor]

#define kWhiteColor [UIColor whiteColor]

#endif /* TSLColorConfig_h */

