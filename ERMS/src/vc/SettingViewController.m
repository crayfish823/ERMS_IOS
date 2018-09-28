//
//  SettingViewController.m
//  ERMS
//
//  Created by 堂堂 on 2018/9/13.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "SettingViewController.h"
#import "MyLayout.h"
#import "MainTabBarController.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
#import "Const.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
@interface SettingViewController ()
@property UITextField *ipTextField;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MyRelativeLayout *contentAll = [MyRelativeLayout new];
    contentAll.wrapContentWidth = NO;
    contentAll.wrapContentHeight = YES;
    contentAll.backgroundColor = [UIColor whiteColor];
    //   contentAll.gravity = MyGravity_Horz_Center;
    //    contentAll.heightDime.lBound(scrollView.heightDime, 5, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    //    [scrollView addSubview:contentAll];
    self.view = contentAll;
    // self.view.backgroundColor = [UIColor blueColor];
   
    
    MyRelativeLayout *titleContent = [MyRelativeLayout new];
    titleContent.myHeight = 75;
    titleContent.myWidth = SCREEN_WIDTH;
    titleContent.backgroundColor = [UIColor colorWithHexString:app_style_color];
    [contentAll addSubview:titleContent];
    
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"image_back"] forState:UIControlStateNormal];
    backBtn.myHeight = 40;
    backBtn.myWidth = 40;
    backBtn.tag = 10;
    backBtn.bottomPos.equalTo(titleContent.bottomPos).offset(5);
    backBtn.leftPos.equalTo(titleContent.leftPos);
    [backBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [titleContent addSubview:backBtn];
    
    
    
  
    
    _ipTextField = [[UITextField alloc] init];
    _ipTextField.myWidth = SCREEN_WIDTH - 100;
    _ipTextField.myHeight = 40;
    _ipTextField.topPos.equalTo(titleContent.bottomPos).offset(20);
    _ipTextField.leftPos.equalTo(contentAll.leftPos).offset(30);
    _ipTextField.rightPos.equalTo(contentAll.rightPos).offset(30);
    _ipTextField.font = [UIFont systemFontOfSize:15];
    _ipTextField.textColor = [UIColor blackColor];
    _ipTextField.placeholder = @"127.0.0.1:8080";
    _ipTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _ipTextField.enabled = YES;
    _ipTextField.textAlignment = NSTextAlignmentCenter;
    _ipTextField.layer.borderWidth = 1;
    _ipTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _ipTextField.userInteractionEnabled = YES;
    _ipTextField.delegate = self;
    _ipTextField.returnKeyType = UIReturnKeyNext;

    [_ipTextField sizeToFit];
    
    [contentAll addSubview:_ipTextField];
    
    
    
    //登录
    UIButton *loginBtn = [UIButton new];
    loginBtn.tag = 11;
    loginBtn.myLeft = 30;
    loginBtn.myRight  = 30;
    loginBtn.myHeight = 46;
    loginBtn.myWidth = SCREEN_WIDTH - 60;
    loginBtn.topPos.equalTo(_ipTextField.bottomPos).offset(50);
    loginBtn.centerXPos.equalTo(contentAll.centerXPos);
    [loginBtn setTitle:@"保存" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[TTUtils createImageWithColor:[UIColor colorWithHexString:app_style_color]] forState:UIControlStateNormal];

    
    [loginBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [contentAll addSubview:loginBtn];
}

-(void)save:(UIView *)view{
    
    int tag = view.tag;
    
    if (tag == 10) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (tag == 11) {
        if ([TTUtils isEmpty:_ipTextField.text]) {
            [self showMessage:@"请输入IP"];
            return;
        }
        
        [UserDefaultUtil saveData:[NSString stringWithFormat:@"http://%@/CACWebAPI/api/",_ipTextField.text] key:URL];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
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

@end
