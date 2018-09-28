//
//  Main5TableViewCell.m
//  JJWL_IOS
//
//  Created by 堂堂 on 2018/5/15.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "Main24TableViewCell.h"
#import "MyLinearLayout.h"
#import "MyRelativeLayout.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
@implementation Main24TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSDictionary *)data index:(NSInteger) index {
    
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textFont = [UIFont systemFontOfSize:12];
    
    
  
    MyLinearLayout *headerContent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    headerContent.myWidth = SCREEN_WIDTH;
    headerContent.myHeight = 40;
    [self.contentView addSubview:headerContent];
    
    if (index % 2 == 0) {
        headerContent.backgroundColor = [UIColor colorWithHexString:list_line_color2];
    }else{
        headerContent.backgroundColor = [UIColor colorWithHexString:list_line_color1];
    }
    
    NSArray *title = @[@"ProjectInfoName",@"TagName",@"TagAlarmType",@"TimeStamp"];
    for (int i = 0; i < title.count; i++) {
        
        
        
        UILabel *lab = [UILabel new];
        lab.textColor = [UIColor whiteColor];
        lab.font = textFont;
        lab.textColor = textColor;
        lab.textAlignment = UITextAlignmentCenter;
        lab.myHeight = headerContent.myHeight;
        lab.wrapContentWidth = YES;
        lab.weight = 1;
        lab.backgroundColor = [UIColor clearColor];
        lab.text = [NSString stringWithFormat:@"%@",data[title[i]]];
        lab.lineBreakMode = UILineBreakModeWordWrap;
        lab.numberOfLines = 0;
        if (i == 2) {
            if ([data[@"TagAlarmType"] intValue] == 1) {
                
                lab.text = [NSString stringWithFormat:@"%@",data[@"ONState"]];
            }
            if ([data[@"TagAlarmType"] intValue] == 0) {
                
                lab.text = [NSString stringWithFormat:@"%@",data[@"OFFState"]];
            }
        }
        if (i == 3) {
            lab.text = [NSString stringWithFormat:@"%@",[TTUtils dateUTCToNow:data[title[i]] oldSf:@"yyyy-MM-dd'T'HH:mm:ss'Z'" nowSf:@"yyyy-MM-dd HH:mm:ss"]];
        }
        [headerContent addSubview:lab];
        
        
        if (i == title.count - 1) {
            continue;
        }
        UIView *line = [UIView new];
        line.myHeight = headerContent.myHeight;
        line.myWidth = 1;
        line.backgroundColor = [UIColor colorWithHexString:list_line_color3];
        [headerContent addSubview:line];
    }
}
@end
