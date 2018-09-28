//
//  AddTableViewCell.m
//  ERMS
//
//  Created by tangtang on 2018/8/22.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "AddTableViewCell.h"
#import "MyLinearLayout.h"
#import "MyRelativeLayout.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"

@implementation AddTableViewCell

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
    
    if (index % 2 ==0) {
        headerContent.backgroundColor = [UIColor colorWithHexString:list_line_color2];
    }else{
        headerContent.backgroundColor = [UIColor colorWithHexString:list_line_color1];
    }
    
    if ([data[@"isCheck"] boolValue]) {
        headerContent.backgroundColor = [UIColor colorWithHexString:@"808080"];
    }
    
    NSArray *title = @[@"ProjectInfoName",@"TagName",@"TagCode"];
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
