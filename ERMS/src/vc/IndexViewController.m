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
@property NSString *DeviceType;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    MyRelativeLayout *contentAll = [MyRelativeLayout new];
    self.DeviceType= [self getDeviceType];
    NSLog(@"设备类型：%@",self.DeviceType);
    NSString* bgName=[NSString stringWithFormat:@"index_%@",self.DeviceType];
    UIImageView *bg = [UIImageView new];
    bg.image = [UIImage imageNamed:bgName];
    
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
            welcome.DeviceType=self.DeviceType;
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

-(NSString*)getDeviceType
{
//    if (_IsPad) {
//        return @"IPAD";
//    }
//    else if(_IsPhone4)
//    {
//        return @"IPHONE4";
//    }
//    else if(_IsPhone5)
//    {
//        return @"IPHONE5";
//    }
//    else if(_IsPhone6)
//    {
//        return @"IPHONE6";
//    }
//    else if(_IsPhone6Plus)
//    {
//        return @"IPHONE6P";
//    }
//    else if(_IsIPHONE_X)
//    {
//        return @"IPHONEX";
//    }
//    else
    if(_IsIPHONE_Xr)
    {
        return @"IPHONEXR";
    }
    else if(_IsIPHONE_Xs)
    {
        return @"IPHONEXS";
    }
    else if(_IsIPHONE_Xs_Max)
    {
        return @"IPHONEXSM";
    }
    else
    {
        return @"";
    }
}

@end
