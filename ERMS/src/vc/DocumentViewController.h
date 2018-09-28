//
//  DocumentViewController.h
//  ERMS
//
//  Created by tangtang on 2018/8/5.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface DocumentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property NSString *ProjectInfoId;

@end
