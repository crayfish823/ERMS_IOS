//
//  IndexViewController.h
//  JJWL_IOS
//
//  Created by 堂堂 on 18/4/16.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import <UIKit/UIKit.h>
//判断是否是ipad
#define _IsPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define _IsPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)
//判断iPhone5系列
#define _IsPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)
//判断iPhone6系列
#define _IsPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)
//判断iphone6+系列
#define _IsPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)
//判断iPhoneX
#define _IsIPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)
//判断iPHoneXr
#define _IsIPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)
//判断iPhoneXs
#define _IsIPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)
//判断iPhoneXs Max
#define _IsIPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !_IsPad : NO)

@interface IndexViewController : UIViewController

@end
