//
//  AddViewController.h
//  ERMS
//
//  Created by tangtang on 2018/8/22.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AddViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray *otherData;

@property void(^dataBack)(NSArray * data);
@end
