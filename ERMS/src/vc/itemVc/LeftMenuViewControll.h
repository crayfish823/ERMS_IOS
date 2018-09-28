//
//  LeftMenuViewControll.h
//  ERMS
//
//  Created by tangtang on 2018/8/19.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLayout.h"
@interface LeftMenuViewControll : MyRelativeLayout<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)void (^backBlock)(int backData);
@property (nonatomic ,strong)UITableView    *contentTableView;
@property NSArray *data;
@property int pos;
@end
