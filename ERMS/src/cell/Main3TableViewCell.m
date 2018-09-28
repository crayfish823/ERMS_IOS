//
//  Main3TableViewCell.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/4/28.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "Main3TableViewCell.h"
#import "MyLinearLayout.h"
#import "MyRelativeLayout.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
#import "UIImageView+WebCache.h"
@implementation Main3TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data headers:(NSArray *) hearderData{
    
    
    
    MyLinearLayout *listContent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    listContent.wrapContentHeight = YES;
    listContent.wrapContentWidth = YES;

    
    MyLinearLayout *item = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    item.myHeight = 40;
    item.wrapContentWidth = YES;
    
    
       
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textFont = [UIFont systemFontOfSize:15];

    
    for(int j = 0 ; j < hearderData.count;j++ ) {
        UILabel *headerLab = [UILabel new];
        headerLab.myWidth = 120;
        headerLab.myHeight = 40;
        headerLab.text = [NSString stringWithFormat:@"%@",data[hearderData[j][@"key"]]];
        headerLab.textColor = textColor;
        headerLab.font = textFont;
        headerLab.backgroundColor = [UIColor whiteColor];
        headerLab.textAlignment = NSTextAlignmentCenter;
        
        if ([@"insert_time" isEqualToString:hearderData[j][@"key"]]) {
            headerLab.font = [UIFont systemFontOfSize:10];
        }
        if ([@"zone_status" isEqualToString:hearderData[j][@"key"]]) {
            MyLinearLayout *imageContent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
            imageContent.myWidth = 180;
            imageContent.myHeight = 40;
            imageContent.contentMode = UIViewContentModeCenter;
            
            
            NSArray *urls = [[NSString stringWithFormat:@"%@",data[hearderData[j][@"key"]]] componentsSeparatedByString:@","];
            for (NSString *url in urls) {
                UIImageView *images = [UIImageView new];
                images.myWidth = 30;
                images.myHeight = 30;
                [images sd_setImageWithURL:[NSURL URLWithString:url]];
                [imageContent addSubview:images];
            }
            [item addSubview:imageContent];
        }else{
            [item addSubview:headerLab];
        }
            
            
            
        
        
        if (j != hearderData.count - 1) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor colorWithHexString:app_bg_color];
            line.myWidth = 2;
            line.myHeight = headerLab.myHeight;
            [item addSubview:line];
            
        }
        
        
        
    }
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    line.myWidth = 122 * (hearderData.count - 1) + 180;
    line.myHeight = 1;
    [item addSubview:line];
    
    
    [listContent addSubview:item];
    [listContent addSubview:line];


    [self.contentView addSubview:listContent];
}

@end
