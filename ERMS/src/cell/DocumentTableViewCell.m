//
//  DocumentTableViewCell.m
//  ERMS
//
//  Created by tangtang on 2018/8/5.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "DocumentTableViewCell.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "MyLayout.h"
#import "TTUtils.h"
@implementation DocumentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSDictionary *)data  index:(int) index{
    
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    MyRelativeLayout * cellView = [MyRelativeLayout new];
    cellView.myWidth = SCREEN_WIDTH;
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.myHeight = 65;
    

    
    UIView *view = [self.contentView viewWithTag:100];
    if (view != nil) {
        [view  removeFromSuperview];
    }
    
    [self.contentView addSubview:cellView];
   
    
    //项目资料
    UIButton *btn1 = [UIButton new];
    
    btn1.myHeight = 26;
    btn1.myWidth = 60;
    [btn1 setTitle:@"下载" forState:UIControlStateNormal];
    btn1.rightPos.equalTo(cellView.rightPos).offset(10);
    btn1.centerYPos.equalTo(cellView.centerYPos);
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.layer.cornerRadius = 3;
    btn1.layer.masksToBounds = YES;
    [btn1 setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:app_style_color]] forState:UIControlStateNormal];
    
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    _downBtn = btn1;
    [cellView addSubview:btn1];
    
    
    //项目名称
    UILabel *lab1 = [UILabel new];
    lab1.wrapContentHeight = YES;
    lab1.myWidth = SCREEN_WIDTH;
    lab1.text = [NSString stringWithFormat:@"%@",data[@"DocumentName"]];
    lab1.leftPos.equalTo(cellView.leftPos).offset(10);
       lab1.rightPos.equalTo(btn1.leftPos).offset(10);
    lab1.centerYPos.equalTo(cellView.centerYPos);
    //lab1.widthSize.equalTo(cellView.widthSize).multiply(0.5);
    lab1.textColor = textColor;
    lab1.font = textFont;
    [lab1 sizeToFit];
    [cellView addSubview:lab1];
   
    
    UIView *line = [UIView new];
    line.leftPos.equalTo(cellView.leftPos);
    line.rightPos.equalTo(cellView.rightPos);
    line.bottomPos.equalTo(cellView.bottomPos).offset(0);
    line.myHeight = 3;
    line.myWidth = SCREEN_WIDTH;
    line.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [cellView addSubview:line];
}
@end
