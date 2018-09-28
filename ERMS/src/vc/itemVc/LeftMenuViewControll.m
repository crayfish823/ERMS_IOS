//
//  LeftMenuViewControll.m
//  ERMS
//
//  Created by tangtang on 2018/8/19.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "LeftMenuViewControll.h"
#import "TTUtils.h"
#import "LeftTableViewCell.h"
#import "Colors.h"
#import "UIColor+Hex.h"
@implementation LeftMenuViewControll

static NSString *ID = @"ViewController";
-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return  self;
}
-(void)initView{
    _pos = 0;
    _data = @[@"趋势",@"趋势对比(日)",@"模拟量查询",@"运转状态查询"];
    
    MyRelativeLayout *content = [MyRelativeLayout new];
    
    content.myWidth = SCREEN_WIDTH;
    content.myHeight = SCREEN_HEIGHT;
    [self addSubview:content];
  
    UIView *view = [UIView new];
    view.myHeight = 65;
    view.leftPos.equalTo(content.leftPos);
    view.rightPos.equalTo(content.rightPos).offset(SCREEN_WIDTH * 0.2);
    view.topPos.equalTo(content.topPos);
    view.backgroundColor = [UIColor colorWithHexString:app_style_color];
    [content addSubview:view];

    
    //中间tableview
    UITableView *contentTableView        = [ UITableView new];
    
    contentTableView.leftPos.equalTo(content.leftPos);
    contentTableView.rightPos.equalTo(view.rightPos);
    contentTableView.topPos.equalTo(view.bottomPos);
    contentTableView.bottomPos.equalTo(content.bottomPos);

    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];
    
    [self.contentTableView reloadData];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    LeftTableViewCell *cell = [[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];

    [cell setData:_data[indexPath.row]];
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
   
    if (_pos == indexPath.row) {
        cell.backgroundColor = [UIColor colorWithHexString:app_style_color alpha:0.8];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    _backBlock(indexPath.row);
    
    _pos = indexPath.row;
    [tableView reloadData];
}
@end
