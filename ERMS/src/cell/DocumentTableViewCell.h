//
//  DocumentTableViewCell.h
//  ERMS
//
//  Created by tangtang on 2018/8/5.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentTableViewCell : UITableViewCell
-(void)setData:(NSDictionary *)data index:(int) index;

@property UIButton *downBtn;
@end
