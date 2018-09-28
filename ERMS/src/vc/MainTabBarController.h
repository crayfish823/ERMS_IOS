//
//  MainTableViewController.h
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController<UITabBarControllerDelegate>
@property(nonatomic,strong)UIButton *selectButton;
- (void)showIndex:(int) index;
@end
