//
//  Main4TableViewCell.m
//  JJWL_IOS
//
//  Created by 堂堂 on 2018/5/15.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "Main4TableViewCell.h"
#import "MyLinearLayout.h"
#import "MyRelativeLayout.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
@implementation Main4TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data index:(NSInteger) index{
    
    
    
    MyRelativeLayout *listContent = [MyRelativeLayout new];
    listContent.myHeight = 84;
    listContent.myWidth = SCREEN_WIDTH;
    listContent.tag = index;
    
    [self.contentView addSubview:listContent];
    
    
    
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textFont = [UIFont systemFontOfSize:14];
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.myHeight = imageView.myWidth = 60;
    imageView.centerYPos.equalTo(listContent.centerYPos);
    imageView.leftPos.equalTo(listContent.leftPos).offset(20);
    imageView.image = [UIImage imageNamed:@"icon_messages1"];
    [listContent addSubview:imageView];
    
    
    //时间
    UILabel *labDate = [UILabel new];
    labDate.text = [NSString stringWithFormat:@"%@",[TTUtils dateUTCToNow:data[@"Timestamp"] oldSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" nowSf:@"yyyy-MM-dd Hh:mm:ss"]];
    labDate.textColor = textColor;
    labDate.font = textFont;
    labDate.wrapContentWidth = YES;
    
    labDate.wrapContentHeight = YES;

    labDate.rightPos.equalTo(listContent.rightPos).offset(10);
    labDate.topPos.equalTo(imageView.topPos);
    [listContent addSubview:labDate];
    
    
    
    //内容
    
    
    UILabel *labContente = [UILabel new];
    labContente.text = [NSString stringWithFormat:@"%@",data[@"MsgContent"]];
    labContente.textColor = [UIColor colorWithHexString:app_text_light_color];
    labContente.font = textFont;
    labContente.wrapContentHeight = YES;
    labContente.wrapContentWidth = YES;
    labContente.rightPos.equalTo(listContent.rightPos).offset(10);
    labContente.leftPos.equalTo(imageView.rightPos).offset(10);
    labContente.bottomPos.equalTo(imageView.bottomPos);
    [listContent addSubview:labContente];
    
    [self.contentView addSubview:listContent];
    
    
    //标题
    UILabel *labTitle = [UILabel new];
    labTitle.text = [NSString stringWithFormat:@"%@",data[@"MsgTitle"]];
    labTitle.textColor = textColor;
    labTitle.font = textFont;
    labTitle.wrapContentHeight = YES;
    labDate.myWidth = SCREEN_WIDTH;
    labTitle.leftPos.equalTo(imageView.rightPos).offset(10);
    labTitle.rightPos.equalTo(labDate.leftPos).offset(5);
    labTitle.topPos.equalTo(imageView.topPos);
    [labTitle sizeToFit];
    [listContent addSubview:labTitle];
    
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:list_line_color];
    line.myHeight = 2;
    line.myWidth = SCREEN_WIDTH;
    line.leftPos.equalTo(listContent.leftPos);
    line.rightPos.equalTo(listContent.rightPos);
    line.bottomPos.equalTo(listContent.bottomPos);
    [listContent addSubview:line];
}
@end
