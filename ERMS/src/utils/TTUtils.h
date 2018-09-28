//
//  TTUtils.h
//  safe_app_ios
//
//  Created by 堂堂 on 17/3/7.
//  Copyright © 2017年 堂堂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)


#define AUTOFITSCREEN_FOR_COORDINATE(x,y,width,hight) CGRectMake(x * CGRectGetWidth([UIScreen mainScreen].bounds) / 375.0, y * CGRectGetHeight([UIScreen mainScreen].bounds) / 667.0, width * CGRectGetWidth([UIScreen mainScreen].bounds) / 375.0, hight * CGRectGetHeight([UIScreen mainScreen].bounds) / 667.0)
#define WIDTH [UIScreen mainScreen].bounds.size.width / 375.0
#define SIZE_WIDTH(x) x * [UIScreen mainScreen].bounds.size.width / 375.0;
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define HTTP_URL @""
@interface TTUtils : NSObject

+(void)getSavePath;
+(BOOL)saveImage:(UIImage *)image;
+(BOOL)saveVideo:(NSData *)data;
//字符串判断
+(BOOL)isEmpty:(NSString *)text;
//空字符串显示
+(NSString *)checkEmpty:(NSString *)text;
//NSDictionary转json字符串
+(NSString*)dictionaryToJson:(id)dic;
//颜色转图片
+(UIImage*)createImageWithColor: (UIColor*) color;
//json字符串转NSDictionary、NSArray
+(id)stringToJSON:(NSString *)data;
//NSData转NSDictionary、NSArray
+(id)dataToJSON:(NSData *)data;
+(NSString *) getTime;
//urlencode
+(NSString *)urlEncode:(NSString *) content;
//图片压缩
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

//utc转本地
+(NSString *) dateUTCToNow:(NSString *)date oldSf:(NSString *)oldSf nowSf:(NSString *)nowSf;
//本地转utc
+(NSString *) dateNowToUTC:(NSString *)date oldSf:(NSString *)oldSf nowSf:(NSString *)nowSf;

+(NSString *)getYYYYMMDD;
@end
