//
//  UIView+AddClickedEvent.h
//  kitchen_app_ios
//
//  Created by 堂堂 on 2018/7/30.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(AddClickedEvent)
 - (void)addClickedBlock:(void(^)(id obj))tapAction;
@end
