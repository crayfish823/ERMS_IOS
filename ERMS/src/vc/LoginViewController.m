//
//  LoginViewController.m
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "LoginViewController.h"
#import "MyLayout.h"
#import "MainTabBarController.h"
#import "UIColor+Hex.h"
#import "Colors.h"
#import "TTUtils.h"
#import "Const.h"
#import "UIColor+Hex.h"
#import "UserDefaultUtil.h"
#import "SettingViewController.h"
#import "JPUSHService.h"
@interface LoginViewController ()

@property UITextField *userName;
@property UITextField *userPwd;
@end

@implementation LoginViewController

UITextField *fieldPwd,*fieldUser;
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

    UIImageView *bg = [UIImageView new];
    bg.image = [UIImage imageNamed:@"login_bg"];
    
    bg.leftPos.equalTo(contentAll.leftPos);
    bg.rightPos.equalTo(contentAll.rightPos);
    
    bg.topPos.equalTo(contentAll.topPos);
    
    bg.bottomPos.equalTo(contentAll.bottomPos);
    
    [contentAll addSubview:bg];
    
    
    //logo
    UILabel *labTitle = [[UILabel alloc] init];
    labTitle.text = @"ERMS远程监控系统";
    [labTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
    labTitle.wrapContentHeight = true;
    labTitle.wrapContentWidth = true;
    labTitle.myAlignment = MyGravity_Center;
    labTitle.myTop = 100;
    labTitle.centerXPos.equalTo(@0);
    labTitle.textColor = [UIColor whiteColor];
    
    [contentAll addSubview:labTitle];
    

   
    
    UILabel *user_image = [UILabel new];
    user_image.textColor = [UIColor whiteColor];
    user_image.text = @"用户名:|";
    user_image.font = [UIFont systemFontOfSize:15];
    user_image.wrapContentHeight = YES;
    user_image.wrapContentWidth = YES;
    user_image.topPos.equalTo(labTitle.bottomPos).offset(120);
    user_image.leftPos.equalTo(@0).offset(30);
    
    
    fieldUser = [[UITextField alloc] init];
    fieldUser.myWidth = SCREEN_WIDTH - 100;
    fieldUser.myHeight = 30;
    fieldUser.leftPos.equalTo(user_image.rightPos).offset(10);
    fieldUser.centerYPos.equalTo(user_image.centerYPos);
    fieldUser.rightPos.equalTo(contentAll.rightPos).offset(30);
    fieldUser.font = [UIFont systemFontOfSize:15];
    fieldUser.textColor = [UIColor whiteColor];
    fieldUser.placeholder = @"请输入用户名";
    fieldUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    fieldUser.enabled = YES;
    fieldUser.userInteractionEnabled = YES;
    fieldUser.delegate = self;
    fieldUser.returnKeyType = UIReturnKeyNext;
    fieldUser.backgroundColor = [UIColor clearColor];
    
    [contentAll addSubview:user_image];
    [contentAll addSubview:fieldUser];
    
    
    
    UIView *line1 = [UIView new];
    line1.myHeight = 1;
    line1.myLeft = 30;
    line1.myRight = 30;
    line1.myWidth = SCREEN_WIDTH - 60;
    line1.topPos.equalTo(user_image.bottomPos).offset(10);
    
    line1.backgroundColor = [UIColor whiteColor];
    [contentAll addSubview:line1];
    
       //密码
   
    UILabel *pwd_image = [UILabel new];
    pwd_image.textColor = [UIColor whiteColor];
    pwd_image.font = [UIFont systemFontOfSize:15];
    pwd_image.text = @"密    码:|";
    pwd_image.wrapContentHeight = YES;
    pwd_image.wrapContentWidth = YES;
    pwd_image.topPos.equalTo(line1.bottomPos).offset(30);
    pwd_image.leftPos.equalTo(@0).offset(30);
    
    
    fieldPwd = [[UITextField alloc] init];
    fieldPwd.myWidth = SCREEN_WIDTH - 100;
    fieldPwd.myHeight = 30;
    fieldPwd.leftPos.equalTo(pwd_image.rightPos).offset(10);
    fieldPwd.rightPos.equalTo(contentAll.rightPos).offset(30);
    fieldPwd.centerYPos.equalTo(pwd_image.centerYPos);
    fieldPwd.font = [UIFont systemFontOfSize:15];
    fieldPwd.textColor = [UIColor whiteColor];
    fieldPwd.placeholder = @"请输入密码";
    fieldPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    fieldPwd.enabled = YES;
    fieldPwd.userInteractionEnabled = YES;
    fieldPwd.delegate = self;
    fieldPwd.returnKeyType = UIReturnKeyNext;
    fieldPwd.rightPos.equalTo(contentAll.rightPos);
    fieldPwd.backgroundColor = [UIColor clearColor];

   


    fieldPwd.secureTextEntry = YES;

    
    
    
    [contentAll addSubview:pwd_image];
    [contentAll addSubview:fieldPwd];
  //  [contentAll addSubview:contentPwd];
    
    
    UIView *line2 = [UIView new];
    line2.myHeight = 1;
    line2.myLeft = 30;
    line2.myRight = 30;
    line2.myWidth = SCREEN_WIDTH - 60;
    line2.topPos.equalTo(pwd_image.bottomPos).offset(10);
    
    line2.backgroundColor = [UIColor whiteColor];
    [contentAll addSubview:line2];
    
    //登录
    UIButton *loginBtn = [UIButton new];
    loginBtn.myLeft = 30;
    loginBtn.myRight  = 30;
    loginBtn.myHeight = 46;
    loginBtn.myWidth = SCREEN_WIDTH - 60;
    loginBtn.topPos.equalTo(line2.bottomPos).offset(50);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    loginBtn.layer.cornerRadius = 23;
    loginBtn.layer.borderWidth = 1;
    
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [contentAll addSubview:loginBtn];

     fieldUser.text = [UserDefaultUtil getData:LOGIN_NAME];
     fieldPwd.text = [UserDefaultUtil getData:LOGIN_PWD];
    

    MyRelativeLayout *settingContent = [MyRelativeLayout new];
    settingContent.rightPos.equalTo(contentAll.rightPos).offset(5);
    settingContent.topPos.equalTo(contentAll.topPos).offset(12);
    settingContent.myWidth = 60;
    settingContent.myHeight = 32;
    settingContent.wrapContentHeight = YES;
    [contentAll addSubview:settingContent];
    
    UIImageView *settingImage = [UIImageView new];
    settingImage.image = [UIImage imageNamed:@"login_setting_image"];
    settingImage.leftPos.equalTo(settingContent.leftPos).offset(10);
    settingImage.centerYPos.equalTo(settingContent.centerYPos);
    settingImage.myHeight = settingImage.myWidth = 20;
    [settingContent addSubview:settingImage];
    
    UILabel *settingLab = [UILabel new];
    settingLab.leftPos.equalTo(settingImage.rightPos).offset(5);
    settingLab.rightPos.equalTo(settingContent.rightPos);
    settingLab.centerYPos.equalTo(settingImage.centerYPos);
    settingLab.text = @"设置";
    settingLab.myWidth = 80;
    settingLab.myHeight = 32;
    settingLab.textColor = [UIColor whiteColor];
    settingLab.font = [UIFont systemFontOfSize:12];
    [settingContent addSubview:settingLab];
    
    UIControl *settingControl = [UIControl new];
    settingControl.leftPos.equalTo(settingContent.leftPos);
    settingControl.topPos.equalTo(settingContent.topPos);
    settingControl.rightPos.equalTo(settingContent.rightPos);
    settingControl.bottomPos.equalTo(settingContent.bottomPos);
    settingControl.tag = 11;
    [settingControl addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [settingContent addSubview:settingControl];
    

    
}
-(void)inputStatus:(id) btn
{
    [btn becomeFirstResponder];
    
}
-(BOOL)becomeFirstResponder{
    return YES;
}


- (void)login {
    NSLog(@"fieldUser.text = %@",fieldUser.text);
    if ([TTUtils isEmpty:fieldUser.text]) {
        [self showMessage:@"请输入用户名"];
        return;
    }
    if ([TTUtils isEmpty:fieldPwd.text]) {
        [self showMessage:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:fieldUser.text forKey:@"LoginName"];
    [param setObject:fieldPwd.text forKey:@"UserPasswd"];
    [param setObject:@"IOS" forKey:@"DeviceType"];

    
    [self showPrograssMessage:@"登录"];
    
    [self httpRequest:param methord:HTTP_LOGIN httpResponsBack:^(NSDictionary *httpBack) {
        [self closePrograssMessage];
        if ([self httpIsSuccess:httpBack]) {
            [UserDefaultUtil saveData:httpBack[@"AccessToken"] key:LOGIN_TOKEN];
            [UserDefaultUtil saveData:[ TTUtils dictionaryToJson:httpBack[@"Roles"]] key:LOGIN_ROLES];
            
            [UserDefaultUtil saveData:fieldUser.text key:LOGIN_NAME];
            [UserDefaultUtil saveData:fieldPwd.text key:LOGIN_PWD];
            [UserDefaultUtil saveData:httpBack[@"User"][@"UserId"] key:USER_ID];
            
            //JPUSH相关 begin
            NSString *userId=httpBack[@"User"][@"UserId"];
            userId = [userId stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSMutableSet *roles=[[NSMutableSet alloc]init];
            for (NSInteger i=0; i<[httpBack[@"Roles"] count]; i++) {
                NSString *roleId= httpBack[@"Roles"][i];
                roleId=[roleId stringByReplacingOccurrencesOfString:@"-" withString:@""];
                [roles addObject:roleId];
            }
            
            //[JPUSHService setTags:[NSSet setWithArray:(NSArray *)httpBack[@"Roles"]]
            [JPUSHService setTags:roles
                       completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                           NSLog(@"setTags: %@",iTags.allObjects);
                       } seq:0];
            
            [JPUSHService setAlias:userId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"setAlias: %@",iAlias);
            } seq:0];
            //JPUSH相关 end
            
            MainTabBarController *mainTab = [[MainTabBarController alloc]init];
         
            [self presentViewController:mainTab animated:YES completion:nil];
        }else{
            [self showMessage:[self httpErrorMessage:httpBack]];
        }
    }];
}

-(void)onClick:(UIView *)view{
    
    SettingViewController *settingVc = [SettingViewController new];
    [self presentViewController:settingVc animated:YES completion:nil];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == fieldUser)
    {
        [fieldUser resignFirstResponder];
        [fieldPwd becomeFirstResponder];
    }
    else
    {
        [fieldPwd resignFirstResponder];
        //然后调用你的登录函数
            }
    
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

@end
