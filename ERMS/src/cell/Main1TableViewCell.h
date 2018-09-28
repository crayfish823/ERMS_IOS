//
//  Main1TableViewCell.h
//  JJWL_IOS
//
//  Created by 堂堂 on 18/4/18.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Main1TableViewCell : UITableViewCell

-(void)setData:(NSDictionary *)data index:(int) index;

@property UIButton *rightBtn;
@property UIButton *leftBtn;
@end
