//
//  DeviceViewController.m
//  ERMS
//
//  Created by tangtang on 2018/8/5.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "DeviceViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "DocumentTableViewCell.h"
#import "MyRelativeLayout.h"
#import "MyLinearLayout.h"
#import "Const.h"
#import "Colors.h"
#import "TTUtils.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
#import "DeviceViewController.h"
#import "DocumentViewController.h"
@interface DeviceViewController ()
@property NSMutableArray *data;
@property UIScrollView *scroll;
@property MyLinearLayout *dataContent;

@end

@implementation DeviceViewController


static NSString *ID = @"ViewController";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"设备一览";
    [self initNavigationBar];
    

    self.parentViewController.tabBarController.tabBar.hidden = YES;
    
    
    MyRelativeLayout * content = [MyRelativeLayout new];
    content.wrapContentHeight = YES;
    content.backgroundColor = [UIColor whiteColor];
    content.frame = self.view.frame;
    self.view = content;
    
    MyLinearLayout *scrollSuper = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    scrollSuper.myHeight = SCREEN_HEIGHT;
    scrollSuper.myWidth = SCREEN_WIDTH;
    scrollSuper.topPos.equalTo(content.topPos);
    scrollSuper.leftPos.equalTo(content.leftPos);
    scrollSuper.rightPos.equalTo(content.rightPos);
    scrollSuper.bottomPos.equalTo(content.bottomPos);
    [content addSubview:scrollSuper];
    
    ;

    _scroll = [UIScrollView new];
    _scroll.heightSize.equalTo(scrollSuper.heightSize);
    _scroll.myWidth = SCREEN_WIDTH;
    _scroll.topPos.equalTo(scrollSuper.topPos);
    _scroll.leftPos.equalTo(scrollSuper.leftPos);
    _scroll.rightPos.equalTo(scrollSuper.rightPos);
    _scroll.bottomPos.equalTo(scrollSuper.bottomPos);
    _scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [scrollSuper addSubview:_scroll];
    
    
    _dataContent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    _dataContent.myWidth = SCREEN_WIDTH;
    _dataContent.wrapContentHeight = YES;
    
    [_scroll addSubview:_dataContent];
    

    
    
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _scroll.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新数据");

        [self getData];
        [_scroll.mj_header endRefreshing];

    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _scroll.mj_header.automaticallyChangeAlpha = YES;
//    scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        NSLog(@"加载更多");
//        [self getData];
//        
//        [scrollView.mj_footer endRefreshing];
//        
//    }];
    // 马上进入刷新状态
    [_scroll.mj_header beginRefreshing];
    
    
    
}

-(void)initNavigationBar{
    
    
    
}

-(void)rightClick{
    
}

-(void)getData{
    
    NSMutableDictionary * param = [NSMutableDictionary new];
    
    [param setObject:[UserDefaultUtil getData:USER_ID] forKey:@"id"];
   
    [self httpRequest:param methord:HTTP_DEVICE httpResponsBack:^(NSDictionary *httpBack) {
        
        NSLog(@"%@",self.ProjectInfoCode);
        if ([self httpIsSuccess:httpBack]) {
         
            NSArray *array = httpBack[@"Entitys"];
            self.data = [NSMutableArray new];
            
            for(NSDictionary *dic in array){
                if (![self.ProjectInfoCode isEqualToString:[NSString stringWithFormat:@"%@",dic[@"ProjectInfoCode"]] ]) {
                    continue;
                }
                
                NSString *str = dic[@"TagGroupName"];
                BOOL flag = YES;
                for(NSDictionary *data1 in self.data) {
                    if ([data1[@"TagGroupName"] isEqualToString:str]) {
                       //存在
                        flag = NO;
                    }
                }
                if (flag) {
                    //不存在
                    NSMutableDictionary *itemData = [NSMutableDictionary new];
                    [itemData setObject:str forKey:@"TagGroupName"];
                    NSMutableArray *arrayStatus = [NSMutableArray new];
                    for (NSDictionary *item in array) {
                        if ([str isEqualToString:item[@"TagGroupName"]]) {
                            [arrayStatus addObject:item];
                        }
                    }
                    [itemData setObject:arrayStatus forKey:@"items"];
                    
                    [self.data addObject:itemData];
                    
                }
                
            }
            
            //显示页面
            [self setView];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}

-(void)setView{
    [_dataContent removeAllSubviews];
    
    int heightAll = 0;
    UIColor *textColor = [UIColor colorWithHexString:app_text_color];
    UIFont *textSize = [UIFont systemFontOfSize:12];
    
    for (int i = 0; i < self.data.count; i++) {
        
        NSDictionary *item = self.data[i];
        
        MyLinearLayout *itemContent = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        itemContent.myWidth = SCREEN_WIDTH;
        [_dataContent addSubview:itemContent];
        
        //设备
        UILabel *labName = [UILabel new];
        labName.font = [UIFont systemFontOfSize:16];
        labName.textColor = textColor;
        labName.text = [NSString stringWithFormat:@"    %@",item[@"TagGroupName"]];
        labName.myWidth = SCREEN_WIDTH;
        labName.myHeight = 40;
        
        labName.backgroundColor = [UIColor colorWithHexString:app_style_color alpha:0.8];
        [itemContent addSubview:labName];
        
        heightAll = heightAll + 40;
        
        for (NSDictionary *dic in item[@"items"]) {
            MyRelativeLayout *statusContent = [MyRelativeLayout new];
            statusContent.myWidth = SCREEN_WIDTH;
            statusContent.myHeight = 40;
            [itemContent addSubview:statusContent];
            
            heightAll = heightAll + 40;

            
            UILabel *labItemName = [UILabel new];
            labItemName.centerYPos.equalTo(statusContent.centerYPos);
            labItemName.wrapContentHeight = YES;
            labItemName.leftPos.equalTo(statusContent.leftPos).offset(18);
            labItemName.font = textSize;
            labItemName.textColor = textColor;
            labItemName.text = [NSString stringWithFormat:@"%@",dic[@"TagName"]];
            
            
          
            
            MyRelativeLayout *lineContent = [MyRelativeLayout new];
            lineContent.centerYPos.equalTo(statusContent.centerYPos);
            lineContent.rightPos.equalTo(statusContent.rightPos).offset(10);
          
            lineContent.myHeight = 30;
            
            
            UILabel *labItemValue = [UILabel new];
            labItemValue.centerYPos.equalTo(statusContent.centerYPos);
            labItemValue.wrapContentHeight = YES;
         //   labItemValue.widthSize.equalTo(statusContent.widthSize).multiply(0.25);
            labItemValue.leftPos.equalTo(labItemName.rightPos).offset(3);
            labItemValue.rightPos.equalTo(lineContent.leftPos).offset(3);
            labItemValue.font = textSize;
            labItemValue.textColor = textColor;
            labItemValue.text = [NSString stringWithFormat:@"%@%@",dic[@"value"],dic[@"UnitCode"]];
        labItemName.widthSize.equalTo(@[labItemValue.widthSize.multiply(0.2),lineContent.widthSize.multiply(0.3)]).multiply(0.4);

            NSString *TagCode = [NSString stringWithFormat:@"%@",dic[@"TagCode"]];
            if ([TagCode hasPrefix:@"AI"]) {
                //AI
                
                lineContent.layer.borderWidth = 1;
                lineContent.layer.borderColor = textColor.CGColor;
                lineContent.layer.masksToBounds = YES;
                
                
                UIView *jindu = [UIView new];
                jindu.leftPos.equalTo(lineContent.leftPos);
                jindu.topPos.equalTo(lineContent.topPos);
                jindu.bottomPos.equalTo(lineContent.bottomPos);
                jindu.backgroundColor = [UIColor colorWithHexString:app_style_color];
                
                
                CGFloat count =  [dic[@"value"] floatValue] / [dic[@"MaxValue"] floatValue];
                jindu.widthSize.equalTo(lineContent).multiply(count);
                [lineContent addSubview:jindu];
            }else{
                //DI
                
                UIView *mark = [UIView new];
                mark.myHeight = mark.myWidth = 24;
                mark.centerXPos.equalTo(lineContent.centerXPos);
                mark.centerYPos.equalTo(lineContent.centerYPos);
                mark.layer.cornerRadius = 12;
                mark.layer.masksToBounds = YES;
                
                [lineContent addSubview:mark];
                
                if ([@"1" isEqualToString:[NSString stringWithFormat:@"%@",dic[@"value"]]]) {
                    //关闭
                    mark.backgroundColor = [UIColor redColor];
                    labItemValue.text = [NSString stringWithFormat:@"%@",dic[@"OFFState"]];

                }else{
                    mark.backgroundColor = [UIColor colorWithHexString:@"#078711"];
                    labItemValue.text = [NSString stringWithFormat:@"%@",dic[@"ONState"]];
                }
                
            }
            
            
            [statusContent addSubview:labItemName];
            [statusContent addSubview:lineContent];

            [statusContent addSubview:labItemValue];
            
            UIView *line = [UIView new];
            line.myHeight = 1;
            line.myWidth = SCREEN_WIDTH;
            line.backgroundColor = [UIColor colorWithHexString:list_line_color];

            [itemContent addSubview:line];
            
            heightAll = heightAll + 1;

        }
      
        UIView *line = [UIView new];
        line.myHeight = 3;
        line.myWidth = SCREEN_WIDTH;
        line.backgroundColor = [UIColor colorWithHexString:list_line_color];

        [itemContent addSubview:line];
        
        heightAll = heightAll + 3;

    }
    _dataContent.wrapContentHeight = YES;
    _scroll.contentSize =CGSizeMake(SCREEN_WIDTH, heightAll);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)



@end
