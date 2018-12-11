//
//  WelcomeViewController.h
//  ERMS
//
//  Created by tangtang on 2018/8/4.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SDCycleScrollView.h"
@interface WelcomeViewController : BaseViewController<SDCycleScrollViewDelegate>
@property NSString* DeviceType;
@end
