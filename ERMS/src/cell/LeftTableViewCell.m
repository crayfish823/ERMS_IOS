//
//  LeftTableViewCell.m
//  ERMS
//
//  Created by tangtang on 2018/8/19.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "MyLayout.h"
#import "Colors.h"
#import "Const.h"
#import "TTUtils.h"
#import "UIColor+Hex.h"
@implementation LeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSString *)data{
    
    MyRelativeLayout *content = [MyRelativeLayout new];
    content.myWidth = SCREEN_WIDTH;
    content.myHeight = 50;
    [self.contentView addSubview:content];
    
    UILabel *lab = [UILabel new];
    lab.text = data;
    lab.textColor = [UIColor colorWithHexString:app_text_color];
    lab.font= [UIFont systemFontOfSize:14];
    lab.leftPos.equalTo(content.leftPos).offset(15);
    lab.rightPos.equalTo(content.rightPos);
    lab.topPos.equalTo(content.topPos);
    lab.bottomPos.equalTo(content.bottomPos);
    [content addSubview:lab];

    
    UIView *line = [UIView new];
    line.backgroundColor  =[UIColor colorWithHexString:list_line_color];
    line.myHeight = 1;
    line.leftPos.equalTo(content.leftPos);
    line.rightPos.equalTo(content.rightPos);

    line.bottomPos.equalTo(content.bottomPos);

    [content addSubview:line];
}

@end
