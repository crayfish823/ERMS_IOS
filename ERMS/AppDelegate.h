//
//  AppDelegate.h
//  ERMS
//
//  Created by tangtang on 2018/8/4.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
//#import <AdSupport/AdSupport.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)BOOL shouldRote;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

