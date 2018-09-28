//
//  MessageDetailViewController.m
//  ERMS
//
//  Created by tangtang on 2018/8/12.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "MyLayout.h"
#import "Const.h"
#import "TTUtils.h"
@interface MessageDetailViewController ()

@property UILabel *labTitle,*labContent,*labDate;
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.title = @"明细";
    self.parentViewController.tabBarController.tabBar.hidden = YES;

    self.navigationItem.backBarButtonItem.title = @"返回";
    
    MyLinearLayout *contentAll = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentAll.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    self.view = contentAll;
    
    UIScrollView *scrollContent = [UIScrollView new];
    scrollContent.myWidth = SCREEN_WIDTH;
    scrollContent.heightSize.equalTo(contentAll.heightSize);
    scrollContent.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    [contentAll addSubview:scrollContent];
    MyLinearLayout *content = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    content.myWidth = SCREEN_WIDTH;
    content.wrapContentHeight = YES;
    [scrollContent addSubview:content];
    scrollContent.wrapContentSize = YES;
    
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    
    
    _labTitle = [UILabel new];
    _labTitle.textColor = textColor;
    _labTitle.myWidth = SCREEN_WIDTH;
    _labTitle.wrapContentHeight = YES;
    _labTitle.myTop = 20;
    _labTitle.font = [UIFont systemFontOfSize:18];
    _labTitle.textAlignment = NSTextAlignmentCenter;
    [content addSubview:_labTitle];
    
    _labDate = [UILabel new];
    _labDate.textColor = textColor;
    _labDate.myWidth = SCREEN_WIDTH;
    _labDate.wrapContentHeight = YES;
    _labDate.myTop = 10;
    _labDate.myRight = 10;
    _labDate.font = [UIFont systemFontOfSize:14];
    _labDate.textAlignment = NSTextAlignmentRight;
    [content addSubview:_labDate];
    
    _labContent = [UILabel new];
    _labContent.textColor = textColor;
    _labContent.myWidth = SCREEN_WIDTH;
    _labContent.wrapContentHeight = YES;
    _labContent.myTop = 10;
    _labContent.myLeft = 10;
    _labContent.myRight = 10;
    _labContent.myBottom = 10;
    _labContent.font = [UIFont systemFontOfSize:14];
    _labContent.textAlignment = NSTextAlignmentLeft;
    _labContent.lineBreakMode = UILineBreakModeWordWrap;
    _labContent.numberOfLines = 0;
    
    [content addSubview:_labContent];
    
    
    _labTitle.text = [NSString stringWithFormat:@"%@",_data[@"MsgTitle"]];
    _labContent.text = [NSString stringWithFormat:@"%@",_data[@"MsgContent"]];
    _labDate.text = [NSString stringWithFormat:@"%@",[TTUtils dateUTCToNow:_data[@"Timestamp"] oldSf:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" nowSf:@"yyyy-MM-dd Hh:mm:ss"]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.tabBarController.tabBar.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.parentViewController.tabBarController.tabBar.hidden = NO;
    
}
@end
