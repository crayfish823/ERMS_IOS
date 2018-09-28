//
//  Main1TableViewCell.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/4/18.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "Main1TableViewCell.h"
#import "MyRelativeLayout.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
#import "MyLinearLayout.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Hex.h"
@implementation Main1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
    }
    
    return self;
}

-(void)setData:(NSDictionary *)data  index:(int) index{
    
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    MyRelativeLayout * cellView = [MyRelativeLayout new];
    cellView.myWidth = SCREEN_WIDTH;
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.myHeight = 90;

    cellView.topPadding = 18;
    
    UIView *view = [self.contentView viewWithTag:100];
    if (view != nil) {
        [view  removeFromSuperview];
    }
    
    [self.contentView addSubview:cellView];
    //项目名称
    UILabel *lab1 = [UILabel new];
    lab1.wrapContentHeight = YES;
    lab1.wrapContentWidth = YES;
    lab1.text = [NSString stringWithFormat:@"项目名称:%@",data[@"ProjectInfoName"]];
    lab1.leftPos.equalTo(cellView.leftPos).offset(10);
    lab1.rightPos.equalTo(cellView.rightPos).offset(10);
    lab1.topPos.equalTo(cellView.topPos);
    lab1.widthSize.equalTo(cellView.widthSize).multiply(0.5);
    lab1.textColor = textColor;
    lab1.font = textFont;
    
    [cellView addSubview:lab1];
    
    //项目资料
    UIButton *btn1 = [UIButton new];
    
    btn1.myHeight = 20;
    btn1.myWidth = 80;
    btn1.tag = index;
    [btn1 setTitle:@"项目资料" forState:UIControlStateNormal];
    btn1.rightPos.equalTo(cellView.rightPos).offset(10);
    btn1.bottomPos.equalTo(cellView.bottomPos).offset(12);
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.layer.cornerRadius = 10;
    btn1.layer.masksToBounds = YES;
    [btn1 setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:@"2ba246"]] forState:UIControlStateNormal];
    
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    _rightBtn = btn1;
    [cellView addSubview:btn1];
    
    //设备一览
    UIButton *btn2 = [UIButton new];
    
    btn2.myHeight = 20;
    btn2.myWidth = 80;
    btn2.tag = index;
    [btn2 setTitle:@"设备一览" forState:UIControlStateNormal];
    btn2.rightPos.equalTo(btn1.leftPos).offset(15);
    btn2.bottomPos.equalTo(cellView.bottomPos).offset(12);
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 10;
    btn2.layer.masksToBounds = YES;
    [btn2 setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:app_style_color]] forState:UIControlStateNormal];
    
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    _leftBtn = btn2;
    [cellView addSubview:btn2];
   
    
    
    UIView *line = [UIView new];
    line.leftPos.equalTo(cellView.leftPos);
    line.rightPos.equalTo(cellView.rightPos);
    line.bottomPos.equalTo(cellView.bottomPos);
    line.myHeight = 3;
    line.myWidth = SCREEN_WIDTH;
    line.backgroundColor = [UIColor colorWithHexString:list_line_color];
    [cellView addSubview:line];
}
@end
