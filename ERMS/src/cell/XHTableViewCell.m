//
//  XHTableViewCell.m
//  ERMS
//
//  Created by tangtang on 2018/8/5.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "XHTableViewCell.h"
#import "MyRelativeLayout.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
#import "MyLinearLayout.h"
#import "UIImageView+WebCache.h"
@implementation XHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setData:(NSDictionary *)data{
    
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    MyRelativeLayout * cellView = [MyRelativeLayout new];
    cellView.myWidth = SCREEN_WIDTH;
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.myHeight = 42;
    cellView.leftPadding = 0;
    cellView.rightPadding = 10;
    
    UILabel *lab = [UILabel  new];
    lab.textColor = textColor;
    lab.text = data[@"TagGroupName"];
    lab.myHeight = 42;
    lab.myWidth = SCREEN_WIDTH;
    lab.leftPos.equalTo(cellView.leftPos).offset(10);
    lab.rightPos.equalTo(cellView.rightPos);
    lab.font = textFont;
    
    [cellView addSubview:lab];
    
    
    UIView *line3 = [UIView new];
    line3.myWidth = SCREEN_WIDTH;
    line3.myHeight = 1;
    line3.leftPos.equalTo(cellView.leftPos).offset(-10);
    line3.rightPos.equalTo(cellView.rightPos).offset(-10);
    line3.bottomPos.equalTo(lab.bottomPos);
    line3.backgroundColor = [UIColor colorWithHexString:list_line_color];
    
    [cellView addSubview:line3];
    
    
    [self.contentView addSubview:cellView];
}
@end
