//
//  IndexViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/4/16.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "MyRelativeLayout.h"
#import "WelcomeViewController.h"
#import "UserDefaultUtil.h"
#import "Const.h"
#import "TTUtils.h"
@interface IndexViewController ()

@property NSTimer *timer;
@property int count;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    MyRelativeLayout *contentAll = [MyRelativeLayout new];
    UIImageView *bg = [UIImageView new];
    bg.image = [UIImage imageNamed:@"index"];
    
    bg.leftPos.equalTo(contentAll.leftPos);
    bg.rightPos.equalTo(contentAll.rightPos);

    bg.topPos.equalTo(contentAll.topPos);

    bg.bottomPos.equalTo(contentAll.bottomPos);

    [contentAll addSubview:bg];
    self.view = contentAll;
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
    [_timer fire];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

-(void)timerCount{
    NSLog(@"tt");
    if (_count == 3) {
        [_timer invalidate];
       // LoginViewController *loginCon = [LoginViewController new];
       // [self presentViewController:loginCon animated:YES completion:nil];
        
    
        if ([TTUtils isEmpty:[UserDefaultUtil getData:INDEX]]) {
            [UserDefaultUtil saveData:@"index" key:INDEX];
            WelcomeViewController *welcome = [WelcomeViewController new];
            [self presentViewController:welcome animated:YES completion:nil];
        }else{
            
             LoginViewController *loginCon = [LoginViewController new];
             [self presentViewController:loginCon animated:YES completion:nil];
        }

    }
    _count++;
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
