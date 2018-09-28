//
//  BaseViewController.m
//  safe_app_ios
//
//  Created by 堂堂 on 17/3/7.
//  Copyright © 2017年 堂堂. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD+MJ.h"
#import "TTUtils.h"
#import "AppDelegate.h"
#import "Const.h"
#import "AFNetworking.h"
#import "UserDefaultUtil.h"
#import "MessageDetailViewController.h"
@interface BaseViewController ()

@property  MBProgressHUD *HUD;
@end

@implementation BaseViewController

-init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _socketManage = [TTSocketManager instance];
    [_socketManage initSocket];
    
    
}


//-(void)viewWillAppear:(BOOL)animated{
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
//}
//- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSLog(@"%@",notification);
//    NSLog(@"%@",notification.userInfo);
//    
//    [UserDefaultUtil saveData:notification.userInfo[@"content"] key:MESSAGE];
//    
//    NSDictionary * userInfo = notification.userInfo;
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
//    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的 Extras 附加字段，key 是自己定义的
//    
//    UIAlertView *altr =[[UIAlertView alloc]initWithTitle:@"提示" message:[TTUtils stringToJSON:notification.userInfo[@"content"]][@"MsgContent"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
//    altr.delegate=self;
//    [altr show];
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    if (buttonIndex == 1) {
        NSString *content = [UserDefaultUtil getData:MESSAGE];
        if (![TTUtils isEmpty:content]) {
            MessageDetailViewController *msgVC = [MessageDetailViewController new];
            msgVC.data = [TTUtils stringToJSON:content];
        [self presentViewController:msgVC animated:YES completion:nil];
        }
    }
}



-(BOOL)httpIsSuccess:(NSDictionary *)data{
    return [[data objectForKey:@"IsSuccess"] boolValue];
}
-(id)httpGetData:(NSDictionary *)data{
    return [data objectForKey:@"result"] ;
}
-(NSString*)httpErrorMessage:(NSDictionary *)data{
    return [data objectForKey:@"Msg"];
}
-(void)sendData:(NSString *) msg dataBack:(void(^)(NSDictionary *dataBack)) dataBack{
    [_socketManage sendData:@"tt" socketBack:dataBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showMessage:(NSString *) msg{
   
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.labelText = msg;
    _HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [_HUD removeFromSuperview];
        _HUD = nil;
    }];
}
-(void)showPrograssMessage:(NSString *) msg{
     [MBProgressHUD showMessage:msg];
}
-(void)closePrograssMessage{
     [MBProgressHUD hideHUD];
}



/*
 http请求
 */
-(void)httpRequest:(NSMutableDictionary *)param methord:(NSString *)method httpResponsBack:(void (^) (id) ) httpResponsBack{
    
    NSLog(@"param=%@",param);
    
    NSString *token = [UserDefaultUtil getData:LOGIN_TOKEN];
    
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@?",[UserDefaultUtil getData:URL],method];
    
    NSLog(@"requestUrl==%@",requestUrl);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    [manager POST:requestUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * data;
        @try {
            NSLog(@"data=%@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
            data = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:0 error:nil];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            httpResponsBack(data);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        httpResponsBack(nil);
    }];
    
}
-(void)downLoadFile:(NSMutableDictionary *)param methord:(NSString *)method httpResponsBack:(void (^) (id) ) httpResponsBack{
    
    NSLog(@"param=%@",param);
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *token = [UserDefaultUtil getData:LOGIN_TOKEN];
    
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@?",SERVICE_URL,method];
    
    NSLog(@"requestUrl==%@",requestUrl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    
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
