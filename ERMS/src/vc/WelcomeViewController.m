//
//  WelcomeViewController.m
//  ERMS
//
//  Created by tangtang on 2018/8/4.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MyRelativeLayout.h"
#import "LoginViewController.h"
#import "TTUtils.h"
#import "UIColor+Hex.h"
@interface WelcomeViewController ()
@property SDCycleScrollView *scrollView;
@property UIButton *enterBtn;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MyRelativeLayout *contentAll = [MyRelativeLayout new];
    contentAll.backgroundColor = [UIColor whiteColor];
    _scrollView = [SDCycleScrollView new];
    _scrollView.leftPos.equalTo(contentAll.leftPos);
    _scrollView.rightPos.equalTo(contentAll.rightPos);
    
    _scrollView.topPos.equalTo(contentAll.topPos);
    
    _scrollView.bottomPos.equalTo(contentAll.bottomPos);
    
    NSArray *imagesURLStrings = @[
                                  @"welcome_1",@"welcome_2"
                                  ];
    
    
    self.scrollView.localizationImageNamesGroup = imagesURLStrings;
    self.scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.scrollView.delegate = self;
    //禁止滚动
    self.scrollView.infiniteLoop = NO;
    self.scrollView.autoScroll = NO;
    self.scrollView.showPageControl = NO;
    self.scrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.scrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [contentAll addSubview:_scrollView];
    
    _enterBtn = [UIButton new];
    _enterBtn.myHeight = 46;
    _enterBtn.myWidth = 100;
    _enterBtn.layer.cornerRadius = 23;
    _enterBtn.layer.masksToBounds = YES;
    _enterBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_enterBtn setTitle:@"现在使用" forState:UIControlStateNormal];
    [_enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_enterBtn setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:@"#B2B2B2"]] forState:UIControlStateNormal];
    _enterBtn.rightPos.equalTo(contentAll.rightPos).offset(30);
    _enterBtn.bottomPos.equalTo(contentAll.bottomPos).offset(50);
    [_enterBtn addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
    _enterBtn.hidden = YES;
    [contentAll addSubview:_enterBtn];
    self.view = contentAll;
}

-(void)onclick{
    LoginViewController *loginVc = [LoginViewController new];
    [self presentViewController:loginVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    if (index == 0) {
        _enterBtn.hidden = YES;
    }else{
        _enterBtn.hidden = NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
