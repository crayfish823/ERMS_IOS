//
//  DeviceTableViewCell.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/4/23.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "DeviceTableViewCell.h"
#import "MyRelativeLayout.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
#import "MyLinearLayout.h"
#import "UIImageView+WebCache.h"
@implementation DeviceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data{
    
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    MyRelativeLayout * cellView = [MyRelativeLayout new];
    cellView.myWidth = SCREEN_WIDTH;
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.wrapContentHeight = YES;
    cellView.leftPadding = 20;
    cellView.rightPadding = 10;
    cellView.topPadding = 8;
    cellView.bottomPadding = 8;
    
    UILabel *lab = [UILabel  new];
    lab.textColor = textColor;
    lab.text = data[@"TagGroupName"];
    lab.myHeight = 30;
    lab.myWidth = 200;
    lab.font = textFont;
    
    [cellView addSubview:lab];
    
    
//    UIView *line3 = [UIView new];
//    line3.myWidth = SCREEN_WIDTH;
//    line3.myHeight = 4;
//    line3.topPos.equalTo(lab.bottomPos).offset(10);
//    line3.leftPos.equalTo(cellView.leftPos).offset(-10);
//    line3.rightPos.equalTo(cellView.rightPos).offset(-10);
//    line3.topPos.equalTo(lab.bottomPos).offset(10);
//    line3.backgroundColor = [UIColor colorWithHexString:app_bg_color];
//    
//    [cellView addSubview:line3];

    
    [self.contentView addSubview:cellView];
}
@end
