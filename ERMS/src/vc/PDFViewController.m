//
//  PDFViewController.m
//  ERMS
//
//  Created by tangtang on 2018/8/23.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "PDFViewController.h"
#import "MyLayout.h"
#import "Const.h"
#import "TTUtils.h"
#import "Colors.h"
#import "UIColor+Hex.h"
@interface PDFViewController ()
@property UIWebView *webView;
@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    
    MyRelativeLayout *contentAll = [MyRelativeLayout new];
    contentAll.backgroundColor = [UIColor colorWithHexString:app_bg_color];
    self.view = contentAll;
    
    _webView = [UIWebView new];
    _webView.leftPos.equalTo(contentAll.leftPos);
    _webView.rightPos.equalTo(contentAll.rightPos);

    _webView.topPos.equalTo(contentAll.topPos);
    _webView.bottomPos.equalTo(contentAll.bottomPos);
    
    [contentAll addSubview:_webView];
    
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:_filePath];
    if (fileExists) {
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:_filePath error:NULL];
        
        long long  localFileLength = [dict[NSFileSize] longLongValue];
        _filePath = [_filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL* url = [[NSURL alloc]initWithString:_filePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    self.parentViewController.tabBarController.tabBar.hidden = NO;

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
