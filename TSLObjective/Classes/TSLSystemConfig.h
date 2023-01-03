//
//  TSLSystemConfig.h
//  Pods
//
//  Created by TSL on 2022/12/29.
//

#ifndef TSLSystemConfig_h
#define TSLSystemConfig_h

#import "TSLViewHelper.h"
#import "TSLFrameDefine.h"

#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)

#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)

#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kWindow [TSLViewHelper getWindow]

#define KAppDelegate [[UIApplication sharedApplication] delegate]

#define kAppCurrentVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] // 获取当前版本号

#define kAppName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] // app名称

#define kBundleIdentifier [[NSBundle mainBundle] bundleIdentifier] // app包名

#define kSystemVersion [[UIDevice currentDevice] systemVersion] // 获取设备系统号

#define kUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString] // UUID

#define kPhoneModel [[UIDevice currentDevice] model] // 设备类型

#define kIsIphone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? YES : NO // iphone设备

#define kIsIpad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? YES : NO // ipad设备

#define kIsIphoneX (fabs(MAX(kScreenWidth, kScreenHeight) / MIN(kScreenWidth, kScreenHeight) - 896.0 / 414.0) < 0.01 || fabs(MAX(kScreenWidth, kScreenHeight) / MIN(kScreenWidth, kScreenHeight) - 812.0 / 375.0) < 0.01)

#define kIsDarkMode [TSLViewHelper getDarkMode]

#endif /* TSLSystemConfig_h */
