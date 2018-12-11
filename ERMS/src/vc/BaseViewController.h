//
//  BaseViewController.h
//  safe_app_ios
//
//  Created by 堂堂 on 17/3/7.
//  Copyright © 2017年 堂堂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSocketManager.h"

@interface BaseViewController : UIViewController
@property TTSocketManager* socketManage;

-(void)showMessage:(NSString *) msg;
-(void)showPrograssMessage:(NSString *) msg;
-(void)closePrograssMessage;
@property (nonatomic, copy) void (^httpRequestBack)(NSDictionary *httpBack);

-(void)httpRequest:(NSDictionary *)param methord:(NSString *)method httpResponsBack:(void (^) (id)) httpRequesrBack;
-(void)downLoadFile:(NSDictionary *)param methord:(NSString *)method httpResponsBack:(void (^) (id)) httpRequesrBack;
-(void)sendData:(NSString *) msg dataBack:(void(^)(NSDictionary *dataBack)) dataBack;

-(BOOL)httpIsSuccess:(NSDictionary *)data;
-(NSString*)httpErrorMessage:(NSDictionary *)data;
-(id)httpGetData:(NSDictionary *)data;

-(NSString*)getDeviceType;
@end
